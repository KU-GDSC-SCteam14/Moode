from flask import Flask, request, jsonify
from nltk import sent_tokenize
from estimate_time import timer
from vaderSentiment.vaderSentiment import SentimentIntensityAnalyzer
from translate import translate_text
from sentiment_analysis import sentiment_analysis

app = Flask(__name__)


@app.route('/post', methods=['POST'])
def post():
    data = request.json  # JSON 형식의 입력 데이터 받기
    if not data or 'input' not in data:
        return jsonify({'error': 'Missing input text'}), 400
    
    input_text = data['input']

    # 감성 분석 수행
    sentiment_result = sentiment_analysis(input_text)

    # 처리 결과를 JSON 형태로 반환
    return jsonify({'sentiment': sentiment_result})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)  # 원하는 포트 번호로 설정
