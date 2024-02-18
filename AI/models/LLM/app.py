from flask import Flask, request, jsonify
from openai import OpenAI
import openai
from dotenv import load_dotenv
import os

load_dotenv()
openai.api_key = os.getenv('OPENAI_API_KEY')

app = Flask(__name__)
client = OpenAI(api_key=openai.api_key)

@app.route('/chat', methods=['POST'])
def chat():
    diary_entry = request.json['diary_entry']
    response = client.chat.completions.create(
        messages=[
            {"role": "system", "content": "You are a helpful assistant that empathizes with the user's feelings."},
            {"role": "user", "content": diary_entry}
        ],
        model="ft:gpt-3.5-turbo-1106:personal::8tMKeom4"
    )
    return jsonify(response=response.choices[0].message.content) # str형태의 공감 텍스트

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5002)  # 원하는 포트 번호로 설정
