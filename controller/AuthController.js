const User = require('../models/UserModel')
const Jurusan = require('../models/JurusanModel')
const argon2 = require('argon2'); 

const validateLoginInput = (username, password) => {
    const errors = {};
    if (!username || username.trim() === '') {
        errors.username = "Username harus diisi.";
    } else if (!/^[a-zA-Z0-9]+$/.test(username)) {
        errors.username = "Username hanya boleh mengandung huruf dan angka saja.";
    }
    if (!password || password.trim() === '') {
        errors.password = "Password harus diisi.";
    } else if (password.length < 5) {
        errors.password = "Password minimal harus 5 karakter.";
    }
    return errors;
};

exports.Login = async(req,res) => {
    const { username, password } = req.body;
    const errors = validateLoginInput(username, password);
    if (Object.keys(errors).length > 0) {
        return res.status(400).json({ msg: "Validasi gagal.", errors });
    }
    try {
        const user = await User.findOne({
            where: { username },
            attributes:['id','name','username','role','password','jurusanId'],
           
        })
        if(!user)
        {return res.status(404).json('user tidak di temukan')}
        const match = await argon2.verify(user.password, password);
        if (!match) {
            return res.status(400).json({ msg: "Password salah." });
        }
        req.session.userId = user.id;
        req.session.userRole = user.role;
        await req.session.save();
        console.log("Session after login:", req.session);
        res.status(200).json({
            id: user.id,
            name: user.name,
            email: user.email,
            role: user.role
        });
        
    } catch (error) {
        res.status(500).json(error.message);
    }
}

exports.Me = async(req,res) => {
    console.log("Session in Me function:", req.session);
    if (!req.session || !req.session.userId) {
        return res.status(401).json({ msg: "Mohon login ke akun Anda!" });
    }

    try {
        const user = await User.findOne({
        attributes: ['id', 'name', 'username', 'role','jurusanId'],
        include: ({
            model: Jurusan,
            attributes:['namaJurusan']
        }),
        where: { id: req.session.userId }
    });
    if (!user) {
        req.session.destroy();
        return res.status(404).json({ msg: "User tidak ditemukan" });
    }
    res.status(200).json({
        kode: '200',
        status: 'succes',
        data: user
    });
        
    } catch (error) {
        return res.status(500).json(error.message)
    }
}

// exports.Logout = async(req, res) => {
//     req.session.destroy((err) => {
//         if (err) return res.status(400).json({ msg: "Tidak dapat logout" });
//         res.status(200).json({ msg: "Anda telah logout" });
//     });
// }
exports.Logout = async(req, res) => {
    try {
        await new Promise((resolve, reject) => {
            req.session.destroy((err) => {
                if (err) reject(err);
                resolve();
            });
        });
        
        // Clear session cookie
        res.clearCookie('connect.sid');
        
        return res.status(200).json({ msg: "Anda telah logout" });
    } catch (err) {
        return res.status(500).json({ msg: "Gagal logout", error: err.message });
    }
};