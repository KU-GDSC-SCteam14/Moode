from openai import OpenAI

client = OpenAI(
    api_key="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"
)

chat_completion = client.chat.completions.create(
    messages=[
        {
            "role": "user",
            "content": "오늘 학교에 갔는데 학교가 닫혀있었어.",
        }
    ],
    model="ftjob-GzmdA9FjF24vv9GNJ5y0txKE",
)
