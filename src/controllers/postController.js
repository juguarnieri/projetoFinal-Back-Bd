const postModel = require("../models/postModel");

const createPost = async (req, res) => {
    const { user_id, title, caption, media_url } = req.body;

    try {
        const post = await postModel.create({ user_id, title, caption, media_url });
        res.status(201).json(post);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Erro ao criar post" });
    }
};
const getUserPosts = async (req, res) => {
    const { userId } = req.params;

    try {
        const posts = await postModel.findByUser(userId);
        res.json(posts);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Erro ao buscar posts do usuário" });
    }
};
const likePost = async (req, res) => {
    const { postId, userId } = req.params;

    try {
        await postModel.like(userId, postId);
        res.json({ message: "Post curtido com sucesso" });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Erro ao curtir post" });
    }
};

const unlikePost = async (req, res) => {
    const { postId, userId } = req.params;

    try {
        await postModel.unlike(userId, postId);
        res.json({ message: "Curtida removida com sucesso" });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Erro ao remover curtida" });
    }
};

module.exports = {
    createPost,
    getUserPosts,
    likePost,
    unlikePost,
    //getLikesCount,
};
