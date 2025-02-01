const express = require('express')

const LaporanController = require('../controller/LaporanController')
const {verifyUsers, adminOnly} = require('../middleware/UserMiddleware')
const router = express.Router()

router.get('/getlaporan',verifyUsers ,LaporanController.getLaporan);
router.get('/getlaporanpaginate',verifyUsers ,LaporanController.getLaporanpaginate);
router.get('/getlaporan/periode',verifyUsers, LaporanController.getLaporanById);
router.post('/createlaporan',verifyUsers, LaporanController.createLaporan);
router.put('/updatelaporan/:id', verifyUsers,LaporanController.updateLaporan);
router.delete('/deletelaporan/:id', verifyUsers,LaporanController.deleteLaporan);
router.get('/downloadpdf', verifyUsers,LaporanController.downloadPdf);

module.exports = router

//dokumentasi route
// GET /laporan/periode?periode=harian&tanggal=2024-01-14

// GET /laporan/periode?periode=bulanan&tanggal=2024-01

// create

// POST /laporan
// Body: {
//     "keterangan": "Laporan kegiatan hari ini",
//     "image": "data:image/jpeg;base64,..."
// }

// update

// PUT /laporan/1
// Body: {
//     "keterangan": "Update laporan kegiatan",
//     "image": "data:image/jpeg;base64,..."
// }

// delete
// DELETE /laporan/1