// /**
//  * npm install pg
//  * 
//  * running at http://localhost:4000
//  */

const express = require('express')
var bodyParser = require('body-parser')
const db = require('./db/index')
const errors = require('./utils/messages_errors')
const cors = require('cors')

var app = express()
app.use(cors())
app.use(bodyParser.json())
PORT = process.env.PORT || 4000

app.set('port', PORT)
app.listen(PORT, function () {
  console.log('Server is running.. on Port 4000')
})

app.get('/users/query_all', function (req, res, next) {
  db.query('SELECT * FROM USERS')
  .then((result) => res.send(result.rows))
  .catch((err) => res.status(500).send(err))
})


/*
{
  'username': ''
  'email': '' 
  'password': ''
}
*/
app.post('/users/signup', function (req, res, next) {
  username = req.body['username']
  email = req.body['email']
  password = req.body['password']

  db.query(
    "INSERT INTO USERS (username, password, email) VALUES($1, $2, $3)", 
    [username, password, email]
  ).then((_) => res.send({
    'status': 'USER_INSERTED',
    'date': Date.now().toString()
  }))
  .catch((err) => {
    var responseError = new Object()
    responseError.status = "401"
    responseError.message = errors[err.code]
    res.send(responseError) 
  })
})
  

/*
{
  'email': '' 
  'password': ''
}
*/
app.post('/users/login', function (req, res, next) {
  email = req.body['email']
  password = req.body['password']

  db.query(
    "SELECT * FROM users WHERE email = $1 AND password = $2",
    [email, password]
  ).then((result) => {
    if(result.rowCount == 0) {
      var responseError = Object()
      responseError.status = "401"
      responseError.message = "USER_UNFOUND"
      res.send(responseError)
    } else {
      res.send({
        'status': 'AUTHORIZED',
        'date': Date.now().toString()
      })
    }
  })
  .catch((err) => res.status(500).send(err))
})