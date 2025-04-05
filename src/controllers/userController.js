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
const followUser = async (req, res) => {
    const { id, targetId } = req.params;
    if (id === targetId) return res.status(400).json({ error: "Você não pode seguir a si mesmo" });

    try {
        await User.follow(id, targetId);
        res.json({ message: "Usuário seguido com sucesso" });
    } catch (err) {
        if (err.message.includes("já está seguindo")) {
            return res.status(400).json({ error: err.message });
        }

        console.error(err);
        res.status(500).json({ error: "Erro ao seguir usuário" });
    }
};

const unfollowUser = async (req, res) => {
    const { id, targetId } = req.params;

    try {
        await User.unfollow(id, targetId);
        res.json({ message: "Deixou de seguir com sucesso" });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Erro ao deixar de seguir" });
    }
};
const getAllUsers = async (req, res) => {
    try {
        const users = await User.findAll();
        res.json(users);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Erro ao buscar usuários" });
    }
};
const updateUser = async (req, res) => {
    const { id } = req.params;
    const { username, name, profile_picture } = req.body;

    try {
        const updatedUser = await User.update(id, { username, name, profile_picture });
        if (!updatedUser) return res.status(404).json({ error: "Usuário não encontrado" });

        res.json({
            message: "✅ Usuário atualizado com sucesso!",
            user: updatedUser
        });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Erro ao atualizar usuário" });
    }
};
const listFollowers = async (req, res) => {
    const { id } = req.params;
    try {
        const followers = await User.getFollowersList(id); 
        res.json(followers);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Erro ao buscar seguidores" });
    }
};

const listFollowing = async (req, res) => {
    const { id } = req.params;
    try {
        const following = await User.getFollowingList(id); 
        res.json(following);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Erro ao buscar seguindo" });
    }
};
const remove = async (id) => {
    const result = await pool.query(
        "DELETE FROM users WHERE id = $1 RETURNING *",
        [id]
    );
    return result.rows[0];
};


module.exports = {
    createUser,
    getUserProfile,
    followUser,
    unfollowUser,
    getAllUsers,  
    updateUser,
    listFollowers,
    listFollowing,
    remove
};