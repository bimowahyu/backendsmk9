const Jurusan = require('../models/JurusanModel')
const User = require('../models/UserModel')

exports.getJurusan = async (req, res) => {
    try {
     
        const jurusan = await Jurusan.findAll({
            attributes: ['id', 'namaJurusan'],
        });
        const calculateJurusan = jurusan.length;

        return res.status(200).json({
            status: 'success',
            kode: '200',
            data: jurusan,
            totalJurusan: calculateJurusan, 
        });
    } catch (error) {
        return res.status(500).json({
            status: 'error',
            kode: '500',
            message: error.message,
        });
    }
};

exports.getJurusanById = async(req,res) =>{
try {
        const data = await Jurusan.findOne({
            id: req.params.id
        })
        return res.status(200).json({
            status: 'success',
            kode:'200',
            data: data
        })
} catch (error) {
    return res.status(50).json(error.message)
}
}

exports.createJurusan = async(req,res) => {
    const {namaJurusan} = req.body
    try {
        await Jurusan.create({
            namaJurusan: namaJurusan
        })
        return res.status(200).json({
            status: 'success',
            kode:'200',
            message: 'Data berhasil ditambahkan'
        })
        
    } catch (error) {
        return res.status(500).json(error.message)
    }
}

exports.updateJurusan = async(req,res) => {
    try {
        const jurusan = await Jurusan.findOne({
            where: {
                id: req.params.id
            }
        })
        if(!jurusan)
            return res.status(404).json({msg: 'jurusan tidak di temukan'})
        await Jurusan.update(
            { namaJurusan: req.body.namaJurusan }, 
            { where: { id: req.params.id } }
        );
        
        return res.status(200).json({
            status: 'success',
            kode:'200',
            message: 'Data berhasil diupdate'
        })
    } catch (error) {
        return res.status(500).json(error.message)
    }
}

exports.deleteJurusan = async(req,res) => {
    try {
        const jurusan = await Jurusan.findOne({
            where:{
                id: req.params.id
            }
        })
        if(!jurusan)
            return res.status(404).json({msg: 'jurusan tidak di temukan'})
        await Jurusan.destroy({
            where:{
                id: jurusan.id 
            }
        })
        return res.status(203).json({
            status: 'success',
            kode:'203',
            message: 'Data berhasil dihapus'
        })
    } catch (error) {
        return res.status(500).json(error.message)
    }
}