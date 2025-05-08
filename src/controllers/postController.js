const pool = require("../config/database");
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
const getLikesCount = async (req, res) => {
    const { postId } = req.params;

    try {
        const count = await postModel.countLikes(postId);
        res.json({ likes: count }); 
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Erro ao contar curtidas" });
    }
};
const getAllPosts = async (req, res) => {
    const { minLikes, title } = req.query;
    try {
        let posts;
    if (minLikes) {
        posts = await postModel.getAllPosts(minLikes);
    } else if (title) {
        posts = await postModel.getPostsTitle(title);
    } else {
        posts = await postModel.getAllPosts();
    }

    res.status(200).json({
            message: "Lista de postagens recuperadas com sucesso",
            total: posts.length,
            data: posts
        });
    } catch (err) {
        console.error("Erro ao buscar postagens", err);
        res.status(500).json({
            error: "Erro ao buscar postagens",
            details: err.message
        })
    }
};
const getPostsByTitle = async (req, res) => {
    try {
        const { title } = req.query;
        const posts = await postModel.getPostsTitle(title);
        res.json(posts);
    } catch (err) {
        res.status(500).json({ error: "Erro ao buscar posts" });
    }
};
const getPostsByStartDate = async (req, res) => {
    try {
        const { startDate } = req.query;
        if (!startDate) {
            return res.status(400).json({ error: "startDate é obrigatório" });
        }
        const posts = await postModel.filterByStartDate(startDate);
        res.json(posts);
    } catch (err) {
        console.error("Erro ao buscar posts:", err);
        res.status(500).json({
            error: "Erro ao buscar posts"});
    }
};

const deletePost = async (req, res) => {
    const { postId } = req.params;

    try {
        const deleted = await postModel.deletePost(postId);
        if (deleted) {
            res.json({ message: "Post deletado com sucesso" });
        } else {
            res.status(404).json({ error: "Post não encontrado" });
        }
    } catch (err) {
        console.error("Erro ao deletar post:", err);
        res.status(500).json({ error: "Erro ao deletar post" });
    }
};



module.exports = {
    createPost,
    getUserPosts,
    likePost,
    unlikePost,
    getLikesCount,
    getAllPosts,
    getPostsByTitle,
    getPostsByStartDate,
    deletePost
};
