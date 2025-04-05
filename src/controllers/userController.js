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
const getUserProfile = async (req, res) => {
    const { id } = req.params;

    try {
        const user = await User.findById(id);
        if (!user) return res.status(404).json({ error: "Usuário não encontrado" });

        const followers = await User.countFollowers(id);
        const following = await User.countFollowing(id);
        const likes = await User.countLikes(id);

        res.json({ ...user, followers, following, likes });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Erro ao buscar perfil" });
    }
};

module.exports = {
    createUser,
    getUserProfile,
    //followUser,
    //unfollowUser,
    //getAllUsers,  
    //updateUser,
    //listFollowers,
    //listFollowing
};