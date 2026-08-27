# app.py
import os
import html
import requests
from bs4 import BeautifulSoup
from flask import Flask, render_template, request
from dotenv import load_dotenv
from openai import OpenAI

load_dotenv()

# API 클라이언트 및 키 초기화
client = OpenAI(api_key=os.getenv('OPENAI_API_KEY'))
NAVER_CLIENT_ID = os.getenv('NAVER_CLIENT_ID')
NAVER_CLIENT_SECRET = os.getenv('NAVER_CLIENT_SECRET')

app = Flask(__name__)


def search_naver_news(query, display=5):
    """네이버 뉴스 검색 API 호출 및 네이버 뉴스 링크 기사만 필터링"""
    url = 'https://naverapihub.apigw.ntruss.com/search/v1/news'
    headers = {
        'X-NCP-APIGW-API-KEY-ID': NAVER_CLIENT_ID,
        'X-NCP-APIGW-API-KEY': NAVER_CLIENT_SECRET
    }
    params = {
        'query': query,
        'sort': 'sim',
        'display': display * 2  # 언론사 자체 링크 제외 대비 여유분 요청
    }
    
    try:
        res = requests.get(url, headers=headers, params=params, timeout=5)
        
        # 네이버 오픈 API 규격 fallback
        if res.status_code != 200:
            url_fallback = 'https://openapi.naver.com/v1/search/news.json'
            headers_fallback = {
                'X-Naver-Client-Id': NAVER_CLIENT_ID,
                'X-Naver-Client-Secret': NAVER_CLIENT_SECRET
            }
            res = requests.get(url_fallback, headers=headers_fallback, params=params, timeout=5)

        data = res.json().get('items', [])
    except Exception as e:
        print(f"네이버 검색 API 호출 에러: {e}")
        return []

    news_items = []
    for item in data:
        link = item.get('link', '')
        if 'naver.com' in link:
            raw_title = item.get('title', '')
            clean_title = html.unescape(raw_title.replace('<b>', '').replace('</b>', ''))
            
            news_items.append({
                'title': clean_title,
                'link': link
            })
            
            if len(news_items) >= int(display):
                break
                
    return news_items


def extract_naver_news(url):
    """기사 URL에서 본문(#dic_area) 텍스트를 크롤링하는 함수"""
    headers = {
        'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0 Safari/537.36'
    }
    try:
        res = requests.get(url, headers=headers, timeout=5)
        if res.status_code != 200:
            return None
            
        soup = BeautifulSoup(res.text, 'html.parser')
        content_tag = soup.select_one('#dic_area, #articeBody, #newsct_article')
        if not content_tag:
            return None
            
        # 불필요한 이미지 설명 캡션 등 제거
        for tag in content_tag.find_all(['em', 'span', 'strong'], class_=['img_desc', 'byline']):
            tag.decompose()
            
        return content_tag.get_text(strip=True)
    except Exception as e:
        print(f"기사 크롤링 실패 ({url}): {e}")
        return None


def generate_comment(content):
    """OpenAI를 호출하여 긍정 댓글을 생성하는 함수"""
    system_msg = "너는 매우 착하고 긍정적인 댓글을 만들어주는 AI야. 기사 내용을 보고 따뜻하고 긍정적인 댓글을 1~2문장으로 만들어줘."
    
    try:
        gpt_res = client.responses.create(
            model='gpt-4.1-mini',
            instructions=system_msg,
            input=content[:2000]
        )
        return gpt_res.output_text
    except Exception:
        try:
            chat_res = client.chat.completions.create(
                model='gpt-4o-mini',
                messages=[
                    {"role": "system", "content": system_msg},
                    {"role": "user", "content": content[:2000]}
                ]
            )
            return chat_res.choices[0].message.content
        except Exception as err:
            return f"댓글 생성 실패: {err}"


# 엔드포인트 1: 입력 화면 (/)
@app.route('/')
def input_page():
    return render_template('in.html')


# 엔드포인트 2: 처리 및 출력 화면 (/out)
@app.route('/out', methods=['GET', 'POST'])
def output_page():
    if request.method == 'POST':
        keyword = request.form.get('keyword', '').strip()
        display = int(request.form.get('display', 5))
    else:
        keyword = request.args.get('keyword', '').strip()
        display = int(request.args.get('display', 5))
        
    if not keyword:
        return render_template('out.html', keyword='', results=[])

    # 1. 키워드로 기사 검색
    searched_news = search_naver_news(keyword, display)
    results = []

    # 2. 각 기사 본문 크롤링 및 AI 댓글 생성
    for item in searched_news:
        content = extract_naver_news(item['link'])
        
        if content:
            comment = generate_comment(content)
            results.append({
                'title': item['title'],
                'link': item['link'],
                'content': content[:140] + '...',
                'comment': comment
            })

    # 3. 결과 화면 렌더링
    return render_template('out.html', keyword=keyword, results=results)


if __name__ == '__main__':
    app.run(debug=True, port=5000)