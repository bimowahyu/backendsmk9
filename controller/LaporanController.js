const Laporan = require('../models/LaporanModel');
const Users = require('../models/UserModel');
const { Op, Sequelize: sequelize } = require('sequelize');
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
            attributes: [],
            include: [{
                model: Jurusan,
                attributes: []
            }]
        }];
        if (user.role === 'admin') {
            includeCondition[0].where = { jurusanId: user.jurusanId };
        } else if (user.role === 'siswa') {
            whereCondition.userId = user.id;
        }

        const totalLaporan = await Laporan.count({
            where: whereCondition,
            include: includeCondition,
        });

        return res.status(200).json({
            code: '200',
            status: 'success',
            totalLaporan: totalLaporan
        });
    } catch (error) {
        console.error('Error:', error);
        return res.status(500).json({ msg: error.message });
    }
};

exports.getLaporanpaginate = async (req, res) => {
    try {
        const user = req.user;

        if (!user) return res.status(404).json({ msg: 'User not found' });

        const page = parseInt(req.query.page) || 1;
        const limit = parseInt(req.query.limit) || 10;
        const month = parseInt(req.query.month);
        const year = parseInt(req.query.year);

        if (page < 1 || limit < 1) {
            return res.status(400).json({ msg: 'Page and limit must be greater than 0' });
        }

        const offset = (page - 1) * limit;

        let whereCondition = {};
        let includeCondition = [{
            model: Users,
            attributes: ['name', 'username', 'jurusanId'],
            include: [{
                model: Jurusan,
                attributes: ['id', 'namaJurusan']
            }]
        }];

        // Role-based filtering
        if (user.role === 'admin') {
            includeCondition[0].where = { jurusanId: user.jurusanId };
        } else if (user.role === 'siswa') {
            whereCondition.userId = user.id;
        }

        // Month filtering
        if (month) {
            whereCondition.tgl_pembuatan = {
                [Op.and]: [
                    sequelize.where(
                        sequelize.fn('MONTH', sequelize.col('tgl_pembuatan')), 
                        month
                    )
                ]
            };
        }

        // Year filtering
        if (year) {
            if (whereCondition.tgl_pembuatan) {
                whereCondition.tgl_pembuatan[Op.and].push(
                    sequelize.where(
                        sequelize.fn('YEAR', sequelize.col('tgl_pembuatan')), 
                        year
                    )
                );
            } else {
                whereCondition.tgl_pembuatan = {
                    [Op.and]: [
                        sequelize.where(
                            sequelize.fn('YEAR', sequelize.col('tgl_pembuatan')), 
                            year
                        )
                    ]
                };
            }
        }

        const totalLaporan = await Laporan.count({
            where: whereCondition,
            include: includeCondition,
        });

        const laporan = await Laporan.findAll({
            where: whereCondition,
            include: includeCondition,
            order: [['tgl_pembuatan', 'DESC']],
            limit: limit,
            offset: offset,
        });

        const totalPages = Math.ceil(totalLaporan / limit);
        
        return res.status(200).json({
            code: '200',
            status: 'success',
            data: laporan,
            totalLaporan: totalLaporan,
            meta: {
                totalPages: totalPages,
                currentPage: page,
                perPage: limit,
            },
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

        let fileName = null;
    
        if (req.files && req.files.image) {
            const file = req.files.image;
            const ext = path.extname(file.name).toLowerCase();
            const allowedTypes = ['.png', '.jpg', '.jpeg'];
            
            if (!allowedTypes.includes(ext)) {
                return res.status(422).json({ msg: 'Invalid file type. Allowed: .png, .jpg, .jpeg' });
            }
            
            const fileSize = file.size;
            if (fileSize > 0.4 * 1024 * 1024) { // 400kb
                return res.status(422).json({ msg: 'File size must be less than 400kb' });
            }

            const tglPembuatan = moment().format('YYYY-MM-DD');
            fileName = `${user.name}-${tglPembuatan}-${Date.now()}${ext}`;
            const uploadPath = path.join(__dirname, '../public/uploads/laporan');
            const filePath = path.join(uploadPath, fileName);

            try {
                await fs.access(uploadPath);
            } catch (error) {
                await fs.mkdir(uploadPath, { recursive: true });
            }

            await file.mv(filePath);
        }

        const tglPembuatan = moment().format('YYYY-MM-DD');
        const laporanData = {
            userId: user.id,
            tgl_pembuatan: tglPembuatan,
            keterangan,
        };
        if (fileName) {
            laporanData.foto_laporan = fileName;
        }

        await Laporan.create(laporanData);

        return res.status(201).json({
            status: true,
            msg: 'Laporan berhasil dibuat',
            data: {
                tgl_pembuatan: tglPembuatan,
                keterangan,
                ...(fileName && { foto_laporan: fileName }),
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
        if (req.files && req.files.image) {
            const file = req.files.image;
            const ext = path.extname(file.name).toLowerCase();
            const allowedTypes = ['.png', '.jpg', '.jpeg'];

            if (!allowedTypes.includes(ext)) {
                return res.status(422).json({ msg: 'Invalid file type. Allowed: .png, .jpg, .jpeg' });
            }
            if (file.size > 0.4 * 1024 * 1024) { // Changed to 400kb to match create
                return res.status(422).json({ msg: 'File size must be less than 400kb' });
            }

            const tglPembuatan = laporan.tgl_pembuatan;
            const newFileName = `${user.name}-${tglPembuatan}-${Date.now()}${ext}`;
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
                ...(updateData.foto_laporan && { foto_laporan: updateData.foto_laporan }),
            },
        });
    } catch (error) {
        console.error('Error in updateLaporan:', error);
        return res.status(500).json({
            msg: 'Internal server error',
            error: error.message,
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

exports.downloadPdf = async (req, res) => {
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

        // Filter berdasarkan bulan & tahun dari query frontend
        const { month, year } = req.query;
        if (month && year) {
            whereCondition.tgl_pembuatan = {
                [Op.between]: [
                    new Date(`${year}-${month}-01`),
                    new Date(`${year}-${month}-31`)
                ]
            };
        }

        const laporan = await Laporan.findAll({
            where: whereCondition,
            include: includeCondition,
            order: [['tgl_pembuatan', 'DESC']]
        });

        const totalLaporan = laporan.length;

        return res.status(200).json({
            code: '200',
            status: 'success',
            data: laporan,
            totalLaporan: totalLaporan
        });
    } catch (error) {
        console.error('Error:', error);
        return res.status(500).json({ msg: error.message });
    }
};
