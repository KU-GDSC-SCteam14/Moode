const express = require('express')
const cors = require('cors') // CORS 미들웨어를 위한 require
const morgan = require('morgan') // morgan 미들웨어를 위한 require
const passport = require('passport')
const jwt = require('jsonwebtoken')
const helmet = require('helmet')
const cookieParser = require('cookie-parser') // cookie-parser 불러오기
require('dotenv').config() // 환경 변수를 로드하기 위해 dotenv.config() 호출
require('./config/passport')(passport)
const db = require('./db')
const axios = require('axios')

const app = express()

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
app.use(cookieParser()) // cookie-parser사용

async function testDBConnection() {
  try {
    await db.query('SELECT 1') // 간단한 쿼리를 실행하여 DB 연결을 테스트합니다.
    console.log('Database connection successful')
  } catch (error) {
    console.error('Unable to connect to the database:', error)
  }
}

// 앱 시작 시 DB 연결을 테스트합니다.
testDBConnection()

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

// 유저 저장 API
app.post('/User', async (req, res) => {
  console.log('User 저장 처리 시작')
  const {
    Name,
    email,
    Signup_date,
    is_Google,
    is_Apple,
    Provider_ID,
    Access_Token,
    Refresh_Token,
    Token_Expiry_Date,
    Profile_Picture_URL,
  } = req.body

  try {
    console.log('User 저장 진입')
    const result = await db.query(
      `INSERT INTO User (Name, email, Signup_date, is_Google, is_Apple, Provider_ID, Access_Token, Refresh_Token, Token_Expiry_Date, Profile_Picture_URL) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)`,
      [
        Name,
        email,
        Signup_date,
        is_Google,
        is_Apple,
        Provider_ID,
        Access_Token,
        Refresh_Token,
        Token_Expiry_Date,
        Profile_Picture_URL,
      ],
    )
    console.log('User 저장 성공')
    console.log(result)
    res.status(201).json({ success: true, userid: result.insertId })
  } catch (error) {
    console.error(error)
    res.status(500).json({ success: false, message: 'Internal Server Error' })
  }
})

// 일기 저장 API
app.post('/diary', async (req, res) => {
  const { User_ID, Title, Content_1, Content_2, Content_3, Date, Mood_ID } =
    req.body

  try {
    const [result] = await db.query(
      `INSERT INTO Diary (User_ID, Title, Content_1, Content_2, Content_3, Date, Mood_ID) VALUES (?, ?, ?, ?, ?, ?, ?)`,
      [User_ID, Title, Content_1, Content_2, Content_3, Date, Mood_ID],
    )
    res.status(201).json({ success: true, diaryId: result.insertId })
  } catch (error) {
    console.error(error)
    res.status(500).json({ success: false, message: 'Internal Server Error' })
  }
})

// 일기 목록 조회 API
app.get('/diaries', async (req, res) => {
  try {
    const [diaries] = await db.query(`SELECT * FROM Diary`)
    res.json({ success: true, diaries })
  } catch (error) {
    console.error(error)
    res.status(500).json({ success: false, message: 'Internal Server Error' })
  }
})

// 감정일기 작성 및 키워드 추출, 감정 분석
app.get('/AIkeyword', (req, res) => {
  // Flask 서버의 URL을 변수로 설정
  const flaskServerUrl = 'http://localhost:5000/post'
  console.log(flaskServerUrl)

  // 요청 본문에 들어갈 데이터. req.query를 직접 사용
  const requestData = req.query
  console.log(requestData)

  axios
    .post(flaskServerUrl, requestData)
    .then((response) => {
      // Flask에서 받은 응답을 그대로 클라이언트에게 전달
      console.log('전송완료')
      // 응답이 이미 전송되었는지 확인
      if (!res.headersSent) {
        res.json(response.data)
        console.log(response.data)
      }
    })
    .catch((error) => {
      console.log('전송실패')
      console.error('Error:', error)
      if (!res.headersSent) {
        res.status(500).json({ success: false, message: 'An error occurred' })
      }
    })
})

app.get('/AImood', (req, res) => {
  // Flask 서버의 URL을 변수로 설정
  const flaskServerUrl = 'http://localhost:5000/post'
  console.log(flaskServerUrl)

  // 요청 본문에 들어갈 데이터. req.query를 직접 사용
  const requestData = req.query
  console.log(requestData)

  axios
    .post(flaskServerUrl, requestData)
    .then((response) => {
      // Flask에서 받은 응답을 그대로 클라이언트에게 전달
      console.log('전송완료')
      // 응답이 이미 전송되었는지 확인
      if (!res.headersSent) {
        res.json(response.data)
        console.log(response.data)
      }
    })
    .catch((error) => {
      console.log('전송실패')
      console.error('Error:', error)
      if (!res.headersSent) {
        res.status(500).json({ success: false, message: 'An error occurred' })
      }
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
app.use((err, req, res) => {
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
