const express = require("express");
const router = express.Router();
const commentController = require("../controllers/commentController");

/**
 * @swagger
 * tags:
 *   name: Comments
 *   description: Operações relacionadas aos comentários dos posts
 */

/**
 * @swagger
 * /api/comments:
 *   get:
 *     summary: Lista todos os comentários
 *     tags: [Comments]
 *     responses:
 *       200:
 *         description: Lista de comentários retornada com sucesso
 *       500:
 *         description: Erro interno do servidor
 */
router.get("/", commentController.getAllComments);

/**
 * @swagger
 * /api/comments:
 *   post:
 *     summary: Cria um novo comentário
 *     tags: [Comments]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - user_id
 *               - post_id
 *               - content
 *             properties:
 *               user_id:
 *                 type: integer
 *               post_id:
 *                 type: integer
 *               content:
 *                 type: string
 *     responses:
 *       201:
 *         description: Comentário criado com sucesso
 *       500:
 *         description: Erro ao criar comentário
 */
router.post("/", commentController.createComment);

/**
 * @swagger
 * /api/comments/{id}:
 *   get:
 *     summary: Busca um comentário por ID
 *     tags: [Comments]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Comentário encontrado
 *       404:
 *         description: Comentário não encontrado
 *       500:
 *         description: Erro ao buscar comentário
 */
router.get("/:id", commentController.getCommentById);

/**
 * @swagger
 * /api/comments/{id}:
 *   put:
 *     summary: Atualiza um comentário (requer o ID do usuário autor)
 *     tags: [Comments]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - content
 *               - user_id
 *             properties:
 *               content:
 *                 type: string
 *               user_id:
 *                 type: integer
 *     responses:
 *       200:
 *         description: Comentário atualizado com sucesso
 *       403:
 *         description: Você não pode atualizar esse comentário
 *       500:
 *         description: Erro ao atualizar comentário
 */
router.put("/:id", commentController.updateComment);

/**
 * @swagger
 * /api/comments/{id}:
 *   delete:
 *     summary: Deleta um comentário por ID
 *     tags: [Comments]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Comentário deletado com sucesso
 *       404:
 *         description: Comentário não encontrado
 *       500:
 *         description: Erro ao deletar comentário
 */
router.delete("/:id", commentController.deleteComment);

/**
 * @swagger
 * /api/comments/post/{postId}:
 *   get:
 *     summary: Lista os comentários de um post específico
 *     tags: [Comments]
 *     parameters:
 *       - in: path
 *         name: postId
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Comentários do post retornados
 *       500:
 *         description: Erro ao buscar comentários do post
 */
router.get("/post/:postId", commentController.getCommentsByPost);

/**
 * @swagger
 * /api/comments/post/{postId}/count:
 *   get:
 *     summary: Retorna a quantidade de comentários de um post
 *     tags: [Comments]
 *     parameters:
 *       - in: path
 *         name: postId
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Contagem de comentários retornada
 *       500:
 *         description: Erro ao contar comentários
 */
router.get("/post/:postId/count", commentController.getCommentsCount);



module.exports = router;
