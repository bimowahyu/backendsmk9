const express = require('express')
const {Login, Logout, Me} = require('../controller/AuthController')


const router = express.Router()

router.post('/login',Login)
router.get('/me',Me)
router.delete('/logout',Logout)

module.exports = router