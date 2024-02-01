const express = require('express')
const cors = require('cors') // CORS 미들웨어를 위한 require
const app = express()

app.use(cors()) // CORS 미들웨어 사용
app.use(express.json())

// 구글 계정으로 로그인
app.post('/auth/login/google', (req, res) => {
  // 구글 로그인 처리 로직
  res.json({
    success: true,
    token: 'google_generated_token',
  })
})

// 애플 계정으로 로그인
app.post('/auth/login/apple', (req, res) => {
  // 애플 로그인 처리 로직
  res.json({
    success: true,
    token: 'apple_generated_token',
  })
})

// 감정일기 작성 및 키워드 추출, 감정 분석
app.post('/diary', (req, res) => {
  // 감정일기 내용 추출, AI를 사용한 키워드 추출 및 감정 분석
  // 감정일기 내용은 처리 후 서버에서 파기

  // 예시 응답
  res.status(201).json({
    success: true,
    message: 'Diary created and analyzed successfully',
    keywords: ['keyword1', 'keyword2'],
    emotionScore: 0.8,
  })
})

/*

// 전체 일기 데이터 백업
app.post('/backup', (req, res) => {
  // 사용자의 전체 일기 데이터 백업 로직
  res.json({
    success: true,
    message: 'Backup completed successfully',
  });
});

// 백업 데이터 복원
app.post('/restore', (req, res) => {
  // 백업 데이터 복원 로직
  // 복원 후 백업된 데이터는 파기

  res.json({
    success: true,
    message: 'Data restored successfully',
  });
});

*/

// 에러 핸들링 미들웨어
app.use((err, req, res, next) => {
  console.error(err.stack) // 에러 로그 출력

  const statusCode = err.statusCode || 500
  const message = err.message || 'Internal Server Error'

  res.status(statusCode).send(message)
})

// 서버 시작
const PORT = process.env.PORT || 3000
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`)
})
