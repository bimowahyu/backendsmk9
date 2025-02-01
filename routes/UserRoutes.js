const express = require('express')

const {getUsers,getUsersById,
    createUsers,
    updateUsers,
    deleteUsers,
    updateProfile,
    uploadUser
} = require('../controller/UserController')

const { verifyUsers, adminOnly } = require('../middleware/UserMiddleware');
const router = express.Router()
const fs = require('fs');
const path = require('path');
const multer = require('multer');

const upload = multer({
    storage: multer.memoryStorage(),
    fileFilter: (req, file, cb) => {
        const allowedTypes = ['application/vnd.openxmlformats-officedocument.spreadsheetml.sheet', 'application/vnd.ms-excel'];
        if (allowedTypes.includes(file.mimetype)) {
            cb(null, true);
        } else {
            cb(new Error('Invalid file type. Only Excel files are allowed.'), false);
        }
    }
});

router.get('/getusers',verifyUsers,getUsers)
router.get('/getusers/:id',verifyUsers,getUsersById)
router.post('/createusers',verifyUsers,createUsers)
router.put('/updateusers/:id',verifyUsers,updateUsers)
router.put('/updateProfile/:id',verifyUsers,updateProfile)
router.delete('/deleteusers/:id',verifyUsers,deleteUsers)
router.post('/registerusersfromexcel',verifyUsers,uploadUser);

module.exports = router