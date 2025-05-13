const express = require("express");
const router = express.Router();
const commentController = require("../controllers/commentController");
const apiKeyMiddleware = require("../config/apiKey");

router.use(apiKeyMiddleware);
/**
 * @swagger
 * tags:
 *   name: Comments
 *   description: Endpoints para gerenciar e acessar comentários em posts
 */
/**
 * @swagger
 * /api/comments/all:
 *   get:
 *     summary: Obtém todos os comentários de todos os posts
 *     tags: [Comments]
 *     responses:
 *       200:
 *         description: Lista de todos os comentários retornada com sucesso
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 type: object
 *                 properties:
 *                   id:
 *                     type: integer
 *                     example: 1
 *                   content:
 *                     type: string
 *                     example: "Muito bom esse post!"
 *                   created_at:
 *                     type: string
 *                     example: "2025-05-12T10:00:00Z"
 *                   user_id:
 *                     type: integer
 *                     example: 1
 *                   username:
 *                     type: string
 *                     example: "joao"
 *                   post_id:
 *                     type: integer
 *                     example: 123
 *                   post_title:
 *                     type: string
 *                     example: "Título do Post"
 *       500:
 *         description: Erro ao buscar comentários
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Erro ao buscar todos os comentários."
 *                 details:
 *                   type: string
 *                   example: "Erro no banco de dados."
 */
router.get("/all", commentController.getAllComments);

/**
 * @swagger
 * /api/comments:
 *   post:
 *     summary: Cria um novo comentário em um post
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
 *                 description: ID do usuário que está comentando
 *                 example: 1
 *               post_id:
 *                 type: integer
 *                 description: ID do post ao qual o comentário pertence
 *                 example: 123
 *               content:
 *                 type: string
 *                 description: Conteúdo do comentário
 *                 example: "Muito bom esse post!"
 *     responses:
 *       201:
 *         description: Comentário criado com sucesso
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 id:
 *                   type: integer
 *                   example: 1
 *                 content:
 *                   type: string
 *                   example: "Muito bom esse post!"
 *                 created_at:
 *                   type: string
 *                   example: "2025-05-12T10:00:00Z"
 *       400:
 *         description: Campos obrigatórios ausentes ou inválidos
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Campos obrigatórios ausentes."
 *                 missing_fields:
 *                   type: array
 *                   items:
 *                     type: string
 *                   example: ["user_id", "post_id", "content"]
 *       500:
 *         description: Erro interno ao criar comentário
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Erro ao criar comentário."
 *                 details:
 *                   type: string
 *                   example: "Erro ao inserir no banco de dados."
 */
router.post("/", commentController.createComment);

/**
 * @swagger
 * /api/comments/{postId}:
 *   get:
 *     summary: Obtém todos os comentários de um post específico
 *     tags: [Comments]
 *     parameters:
 *       - in: path
 *         name: postId
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID do post
 *     responses:
 *       200:
 *         description: Lista de comentários retornada com sucesso
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 type: object
 *                 properties:
 *                   id:
 *                     type: integer
 *                     example: 1
 *                   content:
 *                     type: string
 *                     example: "Muito bom esse post!"
 *                   created_at:
 *                     type: string
 *                     example: "2025-05-12T10:00:00Z"
 *                   user_id:
 *                     type: integer
 *                     example: 1
 *                   username:
 *                     type: string
 *                     example: "joao"
 *       404:
 *         description: Post não encontrado ou sem comentários
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Post não encontrado ou sem comentários."
 *       500:
 *         description: Erro ao buscar comentários
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Erro ao buscar comentários."
 *                 details:
 *                   type: string
 *                   example: "Erro no banco de dados."
 */
router.get("/:postId", commentController.getCommentsByPost);

/**
 * @swagger
 * /api/comments/{id}:
 *   get:
 *     summary: Obtém um comentário específico pelo ID
 *     tags: [Comments]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID do comentário
 *     responses:
 *       200:
 *         description: Comentário encontrado com sucesso
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 id:
 *                   type: integer
 *                   example: 1
 *                 content:
 *                   type: string
 *                   example: "Muito bom esse post!"
 *                 created_at:
 *                   type: string
 *                   example: "2025-05-12T10:00:00Z"
 *       404:
 *         description: Comentário não encontrado
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Comentário não encontrado."
 *       500:
 *         description: Erro ao buscar comentário
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Erro ao buscar comentário."
 *                 details:
 *                   type: string
 *                   example: "Erro no banco de dados."
 */
router.get("/comment/:id", commentController.getCommentById);

/**
 * @swagger
 * /api/comments/{id}:
 *   put:
 *     summary: Atualiza um comentário específico
 *     tags: [Comments]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID do comentário
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - content
 *             properties:
 *               content:
 *                 type: string
 *                 description: Novo conteúdo do comentário
 *                 example: "Comentário atualizado"
 *     responses:
 *       200:
 *         description: Comentário atualizado com sucesso
 *       403:
 *         description: Usuário não tem permissão para atualizar este comentário
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "Você não pode atualizar esse comentário."
 *       404:
 *         description: Comentário não encontrado
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Comentário não encontrado."
 *       500:
 *         description: Erro ao atualizar comentário
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Erro ao atualizar comentário."
 *                 details:
 *                   type: string
 *                   example: "Erro no banco de dados."
 */
router.put("/:id", commentController.updateComment);

/**
 * @swagger
 * /api/comments/{id}:
 *   delete:
 *     summary: Deleta um comentário específico
 *     tags: [Comments]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID do comentário
 *     responses:
 *       200:
 *         description: Comentário deletado com sucesso
 *       404:
 *         description: Comentário não encontrado
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Comentário não encontrado."
 *       500:
 *         description: Erro ao deletar comentário
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Erro ao deletar comentário."
 *                 details:
 *                   type: string
 *                   example: "Erro no banco de dados."
 */
router.delete("/:id", commentController.deleteComment);

/**
 * @swagger
 * /api/comments/count/{postId}:
 *   get:
 *     summary: Obtém o total de comentários de um post
 *     tags: [Comments]
 *     parameters:
 *       - in: path
 *         name: postId
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID do post
 *     responses:
 *       200:
 *         description: Total de comentários retornado com sucesso
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 totalComments:
 *                   type: integer
 *                   example: 5
 *       404:
 *         description: Post não encontrado
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Post não encontrado."
 *       500:
 *         description: Erro ao contar comentários
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Erro ao contar comentários."
 *                 details:
 *                   type: string
 *                   example: "Erro no banco de dados."
 */
router.get("/count/:postId", commentController.getCommentsCount);


module.exports = router;