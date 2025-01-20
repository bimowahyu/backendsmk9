const Laporan = require('../models/LaporanModel');
const Users = require('../models/UserModel');
const { Op } = require('sequelize');
const moment = require('moment');
const { writeFile, unlink } = require('fs').promises;
const fs = require('fs').promises; 
const path = require('path');
const Jurusan = require('../models/JurusanModel')

exports.getLaporan = async (req, res) => {
    try {
        const user = req.user;

        if (!user) return res.status(404).json({ msg: 'User not found' });

        let whereCondition = {};
        let includeCondition = [{
            model: Users,
            attributes: ['name', 'username', 'jurusanId'],
            include: {
                model: Jurusan,
                attributes: ['id', 'namaJurusan']
            }
        }];

        if (user.role === 'admin') {
            includeCondition = [{
                model: Users,
                attributes: ['name', 'username', 'jurusanId'],
                where: { jurusanId: user.jurusanId },
                include: {
                    model: Jurusan,
                    attributes: ['id', 'namaJurusan']
                }
            }];
        } else if (user.role === 'siswa') {
            whereCondition = { userId: user.id };
        }

        const laporan = await Laporan.findAll({
            where: whereCondition,
            include: includeCondition,
            order: [['tgl_pembuatan', 'DESC']]
        });

        const calculateLaporan = laporan.length;

        return res.status(200).json({
            code: '200',
            status: 'success',
            data: laporan,
            totalLaporan: calculateLaporan
        });
    } catch (error) {
        console.error('Error:', error);
        return res.status(500).json({ msg: error.message });
    }
};

exports.getLaporanById = async (req, res) => {
    try {
        const user = req.user;
        if (!user) return res.status(404).json({ msg: 'User not found' });

        const { periode, tanggal } = req.query;
        let whereCondition = { userId: user.id };

        if (periode === 'harian') {
            whereCondition.tgl_pembuatan = moment(tanggal).format('YYYY-MM-DD');
        } else if (periode === 'bulanan') {
            const startDate = moment(tanggal).startOf('month').format('YYYY-MM-DD');
            const endDate = moment(tanggal).endOf('month').format('YYYY-MM-DD');
            whereCondition.tgl_pembuatan = {
                [Op.between]: [startDate, endDate]
            };
        }

        const laporan = await Laporan.findAll({
            where: whereCondition,
            include: [{
                model: Users,
                attributes: ['name', 'username']
            }],
            order: [['tgl_pembuatan', 'DESC']]
        });

        return res.status(200).json(laporan);
    } catch (error) {
        return res.status(500).json({ msg: error.message });
    }
};

exports.createLaporan = async (req, res) => {
    try {

        const user = req.user;
        if (!user) {
            return res.status(404).json({ msg: 'User not found' });
        }

        const { keterangan } = req.body;
        if (!keterangan) {
            return res.status(400).json({ msg: 'Keterangan is required' });
        }
        if (!req.files || !req.files.image) {
            return res.status(400).json({ msg: 'No file uploaded' });
        }
        const file = req.files.image; 
        const ext = path.extname(file.name).toLowerCase();
        const allowedTypes = ['.png', '.jpg', '.jpeg'];
        if (!allowedTypes.includes(ext)) {
            return res.status(422).json({ msg: 'Invalid file type. Allowed: .png, .jpg, .jpeg' });
        }
        const fileSize = file.size;
        if (fileSize > 0.4 * 1024 * 1024) { // 1 400kb
            return res.status(422).json({ msg: 'File size must be less than 400kb' });
        }
        const tglPembuatan = moment().format('YYYY-MM-DD');
        const fileName = `${user.name}-${tglPembuatan}-${Date.now()}${ext}`;
        const uploadPath = path.join(__dirname, '../public/uploads/laporan');
        const filePath = path.join(uploadPath, fileName);
        try {
            await fs.access(uploadPath); 
        } catch (error) {
            await fs.mkdir(uploadPath, { recursive: true }); 
        }
        await file.mv(filePath);

       
        const laporanData = {
            userId: user.id,
            tgl_pembuatan: tglPembuatan,
            foto_laporan: fileName,
            keterangan,
        };

        await Laporan.create(laporanData);

        return res.status(201).json({
            status: true,
            msg: 'Laporan berhasil dibuat',
            data: {
                tgl_pembuatan: tglPembuatan,
                foto_laporan: fileName,
                keterangan,
            },
        });
    } catch (error) {
        console.error('Error in createLaporan:', error);

        return res.status(500).json({
            msg: 'Internal server error',
            error: error.message,
        });
    }
};
exports.updateLaporan = async (req, res) => {
    try {
        const user = req.user;
        if (!user) {
            return res.status(404).json({ msg: 'User not found' });
        }

        const { id } = req.params;
        const { keterangan } = req.body;

        const laporan = await Laporan.findOne({ where: { id } });
        if (!laporan) {
            return res.status(404).json({ msg: 'Laporan tidak ditemukan' });
        }

        if (!keterangan) {
            return res.status(400).json({ msg: 'Keterangan is required' });
        }

        let updateData = { keterangan };
        let newFileName;

        if (req.files && req.files.image) {
            const file = req.files.image;
            const ext = path.extname(file.name).toLowerCase();
            const allowedTypes = ['.png', '.jpg', '.jpeg'];

            if (!allowedTypes.includes(ext)) {
                return res.status(422).json({ msg: 'Invalid file type. Allowed: .png, .jpg, .jpeg' });
            }
            if (file.size > 5 * 1024 * 1024) {
                return res.status(422).json({ msg: 'File size must be less than 5 MB' });
            }

            const tglPembuatan = laporan.tgl_pembuatan;
            newFileName = `${user.name}-${tglPembuatan}-${Date.now()}${ext}`;

            const uploadPath = path.join(__dirname, '../public/uploads/laporan');
            const filePath = path.join(uploadPath, newFileName);

            try {
        
                await fs.access(uploadPath);
            } catch {
  
                await fs.mkdir(uploadPath, { recursive: true });
            }

          
            await file.mv(filePath);

            if (laporan.foto_laporan) {
                const oldFilePath = path.join(uploadPath, laporan.foto_laporan);
                try {
                    await fs.access(oldFilePath);
                    await fs.unlink(oldFilePath);
                } catch (err) {
  
                    console.log('Old file not found:', err.message);
                }
            }

            updateData.foto_laporan = newFileName;
        }

        await Laporan.update(updateData, { where: { id } });

        return res.status(200).json({
            status: true,
            msg: 'Laporan berhasil diupdate',
            data: {
                keterangan,
                foto_laporan: newFileName || laporan.foto_laporan,
            },
        });
    } catch (error) {
        console.error('Error in updateLaporan:', error);
        return res.status(500).json({ 
            msg: 'Internal server error', 
            error: error.message 
        });
    }
};
// Hapus laporan
exports.deleteLaporan = async (req, res) => {
    try {
        const user = req.user;
        if (!user) return res.status(404).json({ msg: 'User not found' });

        const { id } = req.params;
        const isSuperAdminOrAdmin = user.role === 'superadmin' || user.role === 'admin';
        const laporan = await Laporan.findOne({
            where: isSuperAdminOrAdmin 
            ? { id } 
            : { id, userId: user.id }
        });

        if (!laporan) {
            return res.status(404).json({ msg: "Laporan tidak ditemukan" });
        }

        await Laporan.destroy({
            where: { id }
        });

        return res.status(200).json({
            status: true,
            msg: "Laporan berhasil dihapus"
        });

    } catch (error) {
        return res.status(500).json({ msg: error.message });
    }
};