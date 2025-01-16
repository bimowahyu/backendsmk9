const Absensi = require('../models/AbsensiModel')
const User = require('../models/UserModel')
const { writeFile } = require('fs/promises');
const { Op } = require('sequelize');
const moment = require('moment');
const Jurusan = require('../models/JurusanModel');
const fs = require('fs');
const path = require('path');

const today = new Date();
const dayIndex = today.getDay();
const daysOfWeek = ['Minggu', 'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu'];

exports.getAbsensi = async (req, res) => {
    try {
        if (req.userRole === 'superadmin') {
            const absensi = await Absensi.findAll({
                attributes: [
                    'id', 
                    'tgl_absensi', 
                    'jam_masuk', 
                    'jam_keluar', 
                    'foto_masuk', 
                    'foto_keluar', 
                    'userId'
                ],
                include: {
                    model: User,
                    attributes: ['name', 'username', 'jurusanId'],
                    include: {
                        model: Jurusan,
                        attributes: ['id', 'namaJurusan'],
                    },
                },
            });

            return res.status(200).json({
                kode: '200',
                status: 'success',
                data: absensi,
            });

        } else if (req.userRole === 'admin') {
            const absensi = await Absensi.findAll({
                attributes: [
                    'id', 
                    'tgl_absensi', 
                    'jam_masuk', 
                    'jam_keluar', 
                    'foto_masuk', 
                    'foto_keluar', 
                    'userId'
                ],
                include: {
                    model: User,
                    attributes: ['name', 'username', 'jurusanId'],
                    where: { 
                        jurusanId: req.userJurusanId 
                    },
                    include: {
                        model: Jurusan,
                        attributes: ['id', 'namaJurusan'],
                    },
                },
            });
            
            return res.status(200).json({
                kode: '200',
                status: 'success',
                data: absensi,
            });

        } else {
           
            const absensi = await Absensi.findAll({
                where: { userId: req.userId }, 
                attributes: [
                    'id', 
                    'tgl_absensi', 
                    'jam_masuk', 
                    'jam_keluar', 
                    'foto_masuk', 
                    'foto_keluar', 
                    'userId'
                ],
                include: {
                    model: User,
                    attributes: ['name', 'username', 'jurusanId'],
                    include: {
                        model: Jurusan,
                        attributes: ['id', 'namaJurusan'],
                    },
                },
            });
            
            return res.status(200).json({
                kode: '200',
                status: 'success',
                data: absensi,
            });
        }
    } catch (error) {
        return res.status(500).json({ 
            kode: '500', 
            status: 'error', 
            message: error.message 
        });
    }
};


exports.getAbsensiHariIni = async (req, res) => {
    try {
        if (!req.user || !req.user.id) {
            return res.status(400).json({ msg: 'User not authenticated' });
        }

        const hariIni = moment().tz('Asia/Jakarta').format('YYYY-MM-DD');
        const userId = req.user.id;
        const user = await User.findByPk(userId);

        if (!user) {
            return res.status(404).json({ msg: 'User not found' });
        }

        if (req.userRole === 'superadmin') {
            const absensi = await Absensi.findAll({
                where: { tgl_absensi: hariIni },
                attributes: ['id', 'tgl_absensi', 'jam_masuk', 'jam_keluar', 'foto_masuk', 'foto_keluar', 'userId'],
                include: {
                    model: User,
                    attributes: ['name', 'username', 'jurusanId'],
                    include: {
                        model: Jurusan,
                        attributes: ['id', 'namaJurusan'],
                    },
                },
            });
            const totalAbsensi = absensi.length;

            return res.status(200).json({
                kode: '200',
                status: 'success',
                data: absensi,
                totalAbsensi,
            });
        }

        if (req.userRole === 'admin') {
            if (!req.userJurusanId) {
                return res.status(400).json({ msg: 'User department is not set for admin' });
            }

            const absensi = await Absensi.findAll({
                where: { tgl_absensi: hariIni },
                attributes: ['id', 'tgl_absensi', 'jam_masuk', 'jam_keluar', 'foto_masuk', 'foto_keluar', 'userId'],
                include: {
                    model: User,
                    attributes: ['name', 'username', 'jurusanId'],
                    where: { jurusanId: req.userJurusanId },
                    include: {
                        model: Jurusan,
                        attributes: ['id', 'namaJurusan'],
                    },
                },
            });
            const totalAbsensi = absensi.length;

            return res.status(200).json({
                kode: '200',
                status: 'success',
                data: absensi,
                totalAbsensi,
            });
        }

        const absensi = await Absensi.findAll({
            where: { userId: userId, tgl_absensi: hariIni },
            attributes: ['id', 'tgl_absensi', 'jam_masuk', 'jam_keluar', 'foto_masuk', 'foto_keluar', 'userId'],
            include: {
                model: User,
                attributes: ['name', 'username', 'jurusanId'],
                include: {
                    model: Jurusan,
                    attributes: ['id', 'namaJurusan'],
                },
            },
        });

        const totalAbsensi = absensi.length;

        return res.status(200).json({
            kode: '200',
            status: 'success',
            data: absensi,
            totalAbsensi,
        });

    } catch (error) {
        return res.status(500).json({
            kode: '500',
            status: 'error',
            message: error.message,
        });
    }
};


    
exports.getAbsensiById = async(req,res)=>{
    try {
        const response = await Absensi.findOne({
            attributes: ['tgl_absensi', 'jam_masuk', 'jam_keluar'],
            where: { id: req.params.id },
            include: [{
                model: User,
                attributes: ['id', 'name', 'username'],
                include: [{
                    model: Jurusan,
                  
                    attributes: ['id', 'namaJurusan']
                }]
            }]
        });

        if (response) {
            response.jam_masuk = moment(response.jam_masuk, "HH:mm:ss").format("HH:mm");
            response.jam_keluar = moment(response.jam_keluar, "HH:mm:ss").format("HH:mm");
        }

        return res.status(200).json({
            kode: '200',
            status: 'success',
            data: response
        })
    } catch (error) {
        console.error(error);
        res.status(500).send(error.message);
    }
}
function convertToGMT7(dateString) {
    return moment.utc(dateString).tz('Asia/Jakarta').format();
}

// function createAdjustedAbsensi(dataMasuk) {
//     return {
//         ...dataMasuk,
//         createdAt: convertToGMT7(new Date()),
//         updatedAt: convertToGMT7(new Date())
//     };
// }
const isValidWorkingHour = (jam) => {
    const start = moment('07:00:00', 'HH:mm:ss');
    const end = moment('17:00:00', 'HH:mm:ss');
    const current = moment(jam, 'HH:mm:ss');
    return current.isBetween(start, end, null, '[]');
};


exports.createAbsensi = async (req, res) => {
    try {
        const user = req.user;
        if (!user) {
            return res.status(404).json({ msg: 'User not found' });
        }

        const tglAbsensi = moment().format('YYYY-MM-DD');
        const jamMasuk = moment().format('HH:mm:ss');

        if (!isValidWorkingHour(jamMasuk)) {
            return res.status(400).json({
                status: false,
                msg: "Absensi hanya dapat dilakukan pada jam kerja (07:00 - 17:00)"
            });
        }
        const existingAbsensi = await Absensi.findOne({
            where: {
                tgl_absensi: tglAbsensi,
                userId: user.id,
                [Op.or]: [
                    { jam_masuk: { [Op.ne]: null } },
                    { jam_keluar: { [Op.ne]: null } }
                ]
            }
        });

        if (existingAbsensi) {
            return res.status(400).json({ msg: "Anda sudah absen untuk hari ini" });
        }
        if (!req.files || !req.files.image) {
            return res.status(400).json({ msg: 'Image is required' });
        }

        const file = req.files.image;
        const ext = path.extname(file.name).toLowerCase();
        const allowedTypes = ['.png', '.jpg', '.jpeg'];
        if (!allowedTypes.includes(ext)) {
            return res.status(422).json({ msg: 'Invalid file type. Allowed: .png, .jpg, .jpeg' });
        }

        if (file.size > 5 * 1024 * 1024) { // 5 MB
            return res.status(422).json({ msg: 'File size must be less than 5 MB' });
        }

        // Simpan file gambar
        const formatName = `${user.name}-${tglAbsensi}-masuk`;
        const uploadPath = path.join(__dirname, '../public/uploads/absensi');
        const filePath = path.join(uploadPath, `${formatName}${ext}`);

        if (!fs.existsSync(uploadPath)) {
            fs.mkdirSync(uploadPath, { recursive: true });
        }
        await file.mv(filePath);
        const absensiData = {
            userId: user.id,
            tgl_absensi: tglAbsensi,
            jam_masuk: jamMasuk,
            foto_masuk: `${formatName}${ext}`,
        };

        await Absensi.create(absensiData);

        return res.status(200).json({
            status: true,
            msg: "Absensi masuk berhasil tersimpan"
        });

    } catch (error) {
        console.error('Error in createAbsensi:', error);
        return res.status(500).json({
            status: false,
            msg: "Internal server error",
            error: error.message
        });
    }
};
exports.outAbsensi = async (req, res) => {
    try {
        const user = req.user;
        if (!user) {
            return res.status(404).json({ msg: 'User not found' });
        }

        const tglAbsensi = moment().format('YYYY-MM-DD');
        const jamKeluar = moment().format('HH:mm:ss');
        const existingAbsensi = await Absensi.findOne({
            where: {
                tgl_absensi: tglAbsensi,
                userId: user.id,
                jam_masuk: { [Op.ne]: null },
                jam_keluar: null
            }
        });

        if (!existingAbsensi) {
            return res.status(400).json({
                msg: "Anda belum melakukan absen masuk atau sudah melakukan absen keluar"
            });
        }
        if (!req.files || !req.files.image) {
            return res.status(400).json({ msg: 'Image is required' });
        }

        const file = req.files.image;
        const ext = path.extname(file.name).toLowerCase();
        const allowedTypes = ['.png', '.jpg', '.jpeg'];
        if (!allowedTypes.includes(ext)) {
            return res.status(422).json({ msg: 'Invalid file type. Allowed: .png, .jpg, .jpeg' });
        }

        if (file.size > 5 * 1024 * 1024) { // 5 MB
            return res.status(422).json({ msg: 'File size must be less than 5 MB' });
        }
        const formatName = `${user.name}-${tglAbsensi}-keluar`;
        const uploadPath = path.join(__dirname, '../public/uploads/absensi');
        const filePath = path.join(uploadPath, `${formatName}${ext}`);

        if (!fs.existsSync(uploadPath)) {
            fs.mkdirSync(uploadPath, { recursive: true });
        }

        await file.mv(filePath);
        await Absensi.update(
            {
                jam_keluar: jamKeluar,
                foto_keluar: `${formatName}${ext}`
            },
            {
                where: { id: existingAbsensi.id }
            }
        );

        return res.status(200).json({
            status: true,
            msg: "Absensi keluar berhasil tersimpan"
        });

    } catch (error) {
        console.error('Error in outAbsensi:', error);
        return res.status(500).json({
            status: false,
            msg: "Internal server error",
            error: error.message
        });
    }
};

exports.updateAbsensi = async(req,res) => {
    try {
        const { jam_masuk, jam_keluar } = req.body;
        const timeFormat = /^([01]\d|2[0-3]):?([0-5]\d)$/;
        if (!timeFormat.test(jam_masuk) || !timeFormat.test(jam_keluar)) {
            return res.status(400).send('Format waktu tidak valid');
        }

        const absensi = await Absensi.findOne({
            where: { id: req.params.id }
        });

        if (!absensi) {
            return res.status(404).send('Absensi tidak ditemukan');
        }

        await Absensi.update({
            jam_masuk: jam_masuk || absensi.jam_masuk,
            jam_keluar: jam_keluar || absensi.jam_keluar
        }, {
            where: { id: absensi.id }
        });

        res.status(200).send('Absensi berhasil diupdate');
    } catch (error) {
        console.error(error);
        res.status(500).send('Internal Server Error');
    }
};
exports.deleteAbsen = async (req, res) => {
    try {
        const absensi = await Absensi.findOne({
            where: {
                id: req.params.id
            }
        });

        if (!absensi) {
            return res.status(404).send('Absensi tidak ditemukan');
        }

        await absensi.destroy();
        res.status(200).send('Absensi berhasil dihapus');
    } catch (error) {
        res.status(500).json(error.message);
    }
};

