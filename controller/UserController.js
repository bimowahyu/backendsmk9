const User = require('../models/UserModel')
const Jurusan = require('../models/JurusanModel')
const multer = require('multer');
const xlsx = require('xlsx');
const argon2 = require('argon2');

const upload = multer({ dest: 'uploads/' });

exports.getUsers = async (req,res) => {
    try {
       const user = req.user;

        if (!user) return res.status(404).json({ msg: 'User not found' });

        let condition = {};
        if (user.role === 'admin') {
            condition = { '$User.jurusanId$': user.jurusanId }; 
        } else if (user.role === 'siswa') {
            condition = { userId: user.id }; 
        }
        const users = await User.findAll({
            where: condition,
            include: Jurusan,
        });
        res.status(200).json({
            code: '200',
            status: 'success',
            data: users
        });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}

exports.getUsersById = async (req,res) => {
    try {
        const user = await User.findOne({
            where: { id: req.params.id },
            include: Jurusan,
        });
        if (!user) return res.status(404).json({ message: 'User not found' });
        res.status(200).json({
            code: '200',
            status: 'success',
            data: user
        });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}

exports.createUsers = async (req, res) => {
    const { name, username, password, role, jurusanId } = req.body;
    
    try {
     
        if (req.userRole === 'superadmin') {
            const hashedPassword = await argon2.hash(password);
            const newUser = await User.create({
                name,
                username,
                password: hashedPassword,
                role,
                jurusanId: role === 'superadmin' ? null : jurusanId, 
            });

            return res.status(201).json({
                code: '201',
                status: 'success',
                data: newUser,
            });

        } else if (req.userRole === 'admin') {

            if (role !== 'siswa') {
                return res.status(400).json({ message: 'Admins can only create users with the role "siswa".' });
            }
            if (jurusanId !== req.userJurusanId) {
                return res.status(400).json({ message: 'Admin can only create users for their own department.' });
            }

            const hashedPassword = await argon2.hash(password);
            const newUser = await User.create({
                name,
                username,
                password: hashedPassword,
                role,
                jurusanId,
            });

            return res.status(201).json({
                code: '201',
                status: 'success',
                data: newUser,
            });

        } else {
            return res.status(403).json({ message: 'Only superadmin or admin can create users.' });
        }

    } catch (error) {
        return res.status(500).json({ message: error.message });
    }
};


exports.updateUsers = async (req,res) => {
    const { name, username, password, role, jurusanId } = req.body;
    try {
        const user = await User.findOne({ where: { id: req.params.id } });
        if (!user) return res.status(404).json({ message: 'User not found' });
        const finalJurusanId = role === 'superadmin' ? null : jurusanId;
        const hashedPassword = await argon2.hash(password)
        await user.update({
            name,
            username,
            password:hashedPassword,
            role,
            jurusanId: finalJurusanId,
        });
        res.status(200).json({
            code: '200',
            status: 'success',
            data: user
        });
        
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}
//-----------controller update by user
exports.updateProfile = async (req, res) => {
    const { password } = req.body;
    try {
        const user = await User.findOne({ where: { id: req.params.id } });
        if (!user) return res.status(404).json({ message: 'User not found' });
        const updateData = {};
        if (password) {
            updateData.password = await argon2.hash(password);
        }
       
        await user.update(updateData);
        res.status(200).json({
            code: '200',
            status: 'success',
            data: user,
        });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};


exports.deleteUsers = async (req,res) => {
    try {
        const user = await User.findOne({ where: { id: req.params.id } });
        if (!user) return res.status(404).json({ message: 'User not found' });

        await user.destroy();
        res.status(200).json({ message: 'User deleted successfully' });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
}

exports.registerUsersFromExcel = async (req, res) => {
    try {
        if (!req.file) {
            return res.status(400).json({ message: 'File Excel tidak ditemukan' });
        }
        const workbook = xlsx.readFile(req.file.path);
        const sheetName = workbook.SheetNames[0];
        const sheet = workbook.Sheets[sheetName];
        const data = xlsx.utils.sheet_to_json(sheet);
        for (const row of data) {
            const { name, username, role, namaJurusan } = row;
            const jurusan = await Jurusan.findOne({ where: { namaJurusan } });
            if (!jurusan && role !== 'admin') {
                return res.status(400).json({ message: `Jurusan ${namaJurusan} tidak ditemukan` });
            }
            const hashedPassword = await argon2.hash('12345');
            await User.create({
                name,
                username,
                password: hashedPassword,
                role,
                jurusanId: jurusan ? jurusan.id : null,
            });
        }

        res.status(201).json({ message: 'User berhasil diimport dari file Excel' });
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
};