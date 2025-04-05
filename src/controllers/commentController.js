const commentModel = require("../models/commentModel");

const createComment = async (req, res) => {
    const { user_id, post_id, content } = req.body;

    try {
        const comment = await commentModel.createComment({ user_id, post_id, content });
        res.status(201).json(comment);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Erro ao criar comentário" });
    }
};
const getCommentsByPost = async (req, res) => {
    const { postId } = req.params;

    try {
        const comments = await commentModel.getCommentsByPost(postId);
        res.json(comments);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Erro ao buscar comentários" });
    }
};

module.exports = {
    createComment,
    getCommentsByPost,
    //updateComment,
    //deleteComment,
    //getCommentById
    
};
