const User = require("../models/userModel");

const createUser = async (req, res) => {
    const { username, name, profile_picture } = req.body;

    try {
        const user = await User.create({ username, name, profile_picture });
        res.status(201).json(user);
    } catch (err) {
        console.error("Erro ao criar usuário:", err); 
        res.status(500).json({ error: "Erro ao criar usuário", details: err.message }); 
    }
};

module.exports = {
    createUser,
    //getUserProfile,
    //followUser,
    //unfollowUser,
    //getAllUsers,  
    //updateUser,
    //listFollowers,
    //listFollowing
};