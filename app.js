const express = require('express')
const cors = require('cors') // CORS 미들웨어를 위한 require
const morgan = require('morgan') // morgan 미들웨어를 위한 require
const app = express()
const passport = require('passport')
require('./config/passport')(passport) // passport 설정을 별도의 파일로 관리
const jwt = require('jsonwebtoken')
const helmet = require('helmet')
const cookieParser = require('cookie-parser') // cookie-parser 불러오기
require('dotenv').config() // 환경 변수를 로드하기 위해 dotenv.config() 호출

app.use(
  cors({
    origin: process.env.CORS_ORIGIN, // .env 파일에서 클라이언트 도메인을 설정할 수 있습니다.
    credentials: true, // 쿠키를 전달하도록 설정
  }),
)
app.use(express.json())
app.use(morgan('dev')) // 개발용 로그 포맷 사용
app.use(passport.initialize())
app.use(helmet())
app.use(cookieParser()) // cookie-parser 사용

// Google OAuth
app.get(
  '/auth/google',
  passport.authenticate('google', { scope: ['profile', 'email'] }),
)

app.get(
  '/auth/google/callback',
  passport.authenticate('google', { failureRedirect: '/login' }),
  (req, res) => {
    const token = jwt.sign({ id: req.user.id }, process.env.JWT_SECRET_KEY, {
      expiresIn: '1h',
    })
    // 쿠키에 JWT 저장 및 클라이언트로 전송
    res.cookie('jwt', token, { httpOnly: true, secure: true }) // secure: true는 HTTPS 환경에서만 쿠키를 전송
    res.redirect('/')
  },
)

// Apple OAuth
app.get(
  '/auth/apple',
  passport.authenticate('apple', { scope: ['name', 'email'] }),
)

app.get(
  '/auth/apple/callback',
  passport.authenticate('apple', { failureRedirect: '/login' }),
  (req, res) => {
    const token = jwt.sign({ id: req.user.id }, process.env.JWT_SECRET_KEY, {
      expiresIn: '1h',
    })
    // 쿠키에 JWT 저장 및 클라이언트로 전송
    res.cookie('jwt', token, { httpOnly: true, secure: true })
    res.redirect('/')
  },
)

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
const PORT = process.env.PORT || 3000 // .env 파일에서 포트 번호를 설정합니다.
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`)
})
