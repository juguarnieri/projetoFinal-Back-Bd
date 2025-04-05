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
const updateComment = async (req, res) => {
    const { id } = req.params;
    const { content } = req.body;

    try {
        const updated = await commentModel.updateComment(id, content);
        if (!updated) return res.status(404).json({ error: "Comentário não encontrado" });
        res.json(updated);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Erro ao atualizar comentário" });
    }
};
const deleteComment = async (req, res) => {
    const { id } = req.params;

    try {
        const deleted = await commentModel.deleteComment(id);
        if (!deleted) return res.status(404).json({ error: "Comentário não encontrado" });
        res.json({ message: "Comentário deletado com sucesso" });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Erro ao deletar comentário" });
    }
};
const getCommentById = async (req, res) => {
    const { id } = req.params;

    try {
        const comment = await commentModel.getCommentById(id);
        if (!comment) return res.status(404).json({ error: "Comentário não encontrado" });
        res.json(comment);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Erro ao buscar comentário" });
    }
};
const countComments = async (req, res) => {
    const { postId } = req.params;

    try {
        const count = await commentModel.countCommentsByPost(postId);
        res.json({ totalComments: count });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Erro ao contar comentários" });
    }
};

module.exports = {
    createComment,
    getCommentsByPost,
    updateComment,
    deleteComment,
    getCommentById,
    countComments    
};
