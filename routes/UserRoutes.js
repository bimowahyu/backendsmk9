const express = require('express')

const {getUsers,getUsersById,
    createUsers,
    updateUsers,
    deleteUsers,
    registerUsersFromExcel,
    updateProfile
} = require('../controller/UserController')
const multer = require('multer');
const { verifyUsers, adminOnly } = require('../middleware/UserMiddleware');
const router = express.Router()

const upload = multer({ dest: 'uploads/' });

router.get('/getusers',verifyUsers,getUsers)
router.get('/getusers/:id',verifyUsers,getUsersById)
router.post('/createusers',verifyUsers,createUsers)
router.put('/updateusers/:id',verifyUsers,updateUsers)
router.put('/updateProfile/:id',verifyUsers,updateProfile)
router.delete('/deleteusers/:id',verifyUsers,deleteUsers)
router.post('/registerusersfromexcel',verifyUsers,upload.single('file'),registerUsersFromExcel)


module.exports = router