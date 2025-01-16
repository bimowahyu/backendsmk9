const User = require('../models/UserModel')
const Jurusan = require('../models/JurusanModel')

exports.adminOnly = async(req,res, next) => {
    if (!req.session.userId) {
        return res.status(401).json({ msg: "Silahkan login akun admin" });
    }
    try {
        const admin = await Users.findByPk(req.session.userId, {
            attributes: ['id', 'name', 'username', 'role']
        });
        if (!admin) {
            return res.status(404).json({ msg: "Akun admin tidak ditemukan" });
        }
        if (admin.role !== 'admin') {
            return res.status(403).json({ msg: "Anda tidak memiliki izin untuk melakukan operasi ini" });
        }
        req.admin = admin;
        req.userRole = admin.role;
        req.userJurusanId = user.jurusanId; 
        next();
        
    } catch (error) {
        return res.status(500).json(error.message)
    }
}

exports.verifyUsers = async (req,res,next) => {
    try {
        if (!req.session.userId) {
            return res.status(401).json({ msg: "Silahkan login" });
        }
        const user = await User.findOne({
            where: { id: req.session.userId },
            attributes: ['id', 'name','username', 'role', 'jurusanId'],
            include: [{
              model: Jurusan,
              attributes: ['id', 'namaJurusan'],
              required: false 
            }]
          });
          if (!user) {
            return res.status(401).json({
              status: false,
              message: "User tidak ditemukan"
            });
          }
      
          req.user = req.session.user;
          req.user = user;
          req.userId = user.id;
          req.userRole = user.role;
          req.userJurusanId = user.jurusanId;
          
          next();
    } catch (error) {
        return res.status(500).json(error.message)
    }
}