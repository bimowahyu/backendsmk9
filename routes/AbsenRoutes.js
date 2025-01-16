const express = require('express')

const {getAbsensi,getAbsensiById,
    getAbsensiHariIni,    
    createAbsensi,
    outAbsensi,
    updateAbsensi,
    deleteAbsen
} = require('../controller/AbsensiController')
const {verifyUsers,adminOnly} = require('../middleware/UserMiddleware')
const router = express.Router()

router.get('/getabsensi',verifyUsers,getAbsensi)
router.get('/getabsen/:id',getAbsensiById)
router.get('/getabsenhariini',verifyUsers,getAbsensiHariIni)
router.post('/createabsensi',verifyUsers,createAbsensi)
router.post('/outabsensi',verifyUsers,outAbsensi)
router.put('/updateabsensi/:id',updateAbsensi)
router.delete('/deleteabsen/:id',deleteAbsen)

module.exports = router