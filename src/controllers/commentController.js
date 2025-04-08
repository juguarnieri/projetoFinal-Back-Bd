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
    console.log("Buscando comentários para post:", postId); // <-- aqui

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
    const { content, user_id } = req.body;

    try {
        const updated = await commentModel.updateComment(id, content, user_id);

        if (!updated) {
            return res.status(403).json({ message: 'Você não pode atualizar esse comentário' });
        }

        res.status(200).json({ message: 'Comentário atualizado com sucesso' });
    } catch (error) {
        console.error('Erro ao atualizar comentário:', error);
        res.status(500).json({ message: 'Erro interno ao atualizar comentário' });
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
