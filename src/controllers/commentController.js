const commentModel = require("../models/commentModel");
const postModel = require("../models/postModel"); 

const createComment = async (req, res) => {
    const { user_id, post_id, content } = req.body;

    try {
        const postExists = await postModel.getPostById(post_id);
        if (!postExists) {
            return res.status(400).json({ error: "O post associado não existe." });
        }
        const comment = await commentModel.createComment({ user_id, post_id, content });
        res.status(201).json(comment);
    } catch (err) {
        console.error("Erro ao criar comentário:", err);
        res.status(500).json({ error: "Erro ao criar comentário" });
    }
};

const getCommentsByPost = async (req, res) => {
    const { postId } = req.params;

    try {
        const comments = await commentModel.getCommentsByPost(postId);

        if (comments.length === 0) {
            return res.status(404).json({ error: "Post não encontrado ou sem comentários." });
        }

        res.status(200).json(comments);
    } catch (err) {
        console.error("Erro ao buscar comentários:", err);
        res.status(500).json({ error: "Erro ao buscar comentários.", details: err.message });
    }
};

const getCommentById = async (req, res) => {
    const { id } = req.params;

    try {
        const comment = await commentModel.getCommentById(id);

        if (!comment) {
            return res.status(404).json({ error: "Comentário não encontrado." });
        }

        res.status(200).json(comment);
    } catch (err) {
        console.error("Erro ao buscar comentário:", err);
        res.status(500).json({ error: "Erro ao buscar comentário.", details: err.message });
    }
};

const updateComment = async (req, res) => {
    const { id } = req.params; 
    const { content } = req.body; 
    const userId = req.user?.id || 1; 

    try {

        const comment = await commentModel.getCommentById(id);
        if (!comment) {
            return res.status(404).json({ error: "Comentário não encontrado." });
        }

        if (comment.user_id !== userId) {
            return res.status(403).json({ message: "Você não pode atualizar esse comentário." });
        }

        const updatedComment = await commentModel.updateComment(id, content, userId);
        if (!updatedComment) {
            return res.status(500).json({ error: "Erro ao atualizar comentário." });
        }

        res.status(200).json({
            message: "Comentário atualizado com sucesso.",
            data: updatedComment,
        });
    } catch (error) {
        console.error("Erro ao atualizar comentário:", error);
        res.status(500).json({ error: "Erro ao atualizar comentário.", details: error.message });
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

const getCommentsCount = async (req, res) => {
    const { postId } = req.params;

    try {
        const count = await commentModel.countCommentsByPost(postId);
        res.json({ totalComments: count });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Erro ao contar comentários" });
    }
};

const getAllComments = async (req, res) => {
    try {
      const comments = await commentModel.getAllComments();
      res.json(comments);
    } catch (error) {
      console.error('Erro ao buscar comentários:', error);
      res.status(500).json({ message: 'Erro interno do servidor' });
    }
  };

module.exports = {
    createComment,
    getCommentsByPost,
    updateComment,
    deleteComment,
    getCommentById,
    getCommentsCount,
    getAllComments
};
