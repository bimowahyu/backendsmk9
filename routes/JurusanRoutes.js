const express = require('express')

const {getJurusan,getJurusanById,
    createJurusan,
    updateJurusan,
    deleteJurusan
} = require('../controller/JurusanController')
const {verifyUsers, adminOnly} = require('../middleware/UserMiddleware')
const router = express.Router()


router.get('/getjurusan',verifyUsers,getJurusan)
router.get('/getjurusan/:id',verifyUsers,getJurusanById)
router.post('/createjurusan',verifyUsers,createJurusan)
router.put('/updatejurusan/:id',verifyUsers,updateJurusan)
router.delete('/deletejurusan/:id',verifyUsers,deleteJurusan)

module.exports = router