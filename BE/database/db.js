const mysql = require('mysql2/promise')
require('dotenv').config()

// 데이터베이스 연결 정보 설정
const pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  database: process.env.DB_NAME,
  password: process.env.DB_PASSWORD,
  waitForConnections: true,
  connectionLimit: 10, // 연결 풀에 유지할 최대 연결 수
  queueLimit: 0, // 연결 요청 대기열의 최대 크기, 0은 무제한
})

// 데이터베이스 쿼리를 실행하는 함수 예시
async function query(sql, params) {
  const [rows, fields] = await pool.execute(sql, params)
  return rows
}

// 데이터베이스 연결 풀 종료
async function closePool() {
  await pool.end()
}

module.exports = { query, closePool }
