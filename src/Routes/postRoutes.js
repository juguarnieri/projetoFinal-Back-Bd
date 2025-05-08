const express = require("express");
const router = express.Router();
const postController = require("../controllers/postController");

/**
 * @swagger
 * tags:
 *   name: Posts
 *   description: Operações relacionadas aos posts
 */

/**
 * @swagger
 * /api/posts:
 *   get:
 *     summary: Retorna todos os posts
 *     tags: [Posts]
 *     responses:
 *       200:
 *         description: Lista de posts retornada com sucesso
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
 *                   title:
 *                     type: string
 *                     example: "Título do post"
 *                   content:
 *                     type: string
 *                     example: "Conteúdo do post."
 *                   userId:
 *                     type: integer
 *                     example: 1
 *                   createdAt:
 *                     type: string
 *                     example: "2025-05-07T15:00:00Z"
 *       500:
 *         description: Erro interno do servidor
 */
router.get("/", postController.getAllPosts);

/**
 * @swagger
 * /api/posts:
 *   post:
 *     summary: Cria um novo post
 *     tags: [Posts]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - title
 *               - content
 *             properties:
 *               title:
 *                 type: string
 *               content:
 *                 type: string
 *               userId:
 *                 type: integer
 *     responses:
 *       201:
 *         description: Post criado com sucesso
 *       500:
 *         description: Erro ao criar post
 */
router.post("/", postController.createPost);

/**
 * @swagger
 * /api/posts/usuario/{userId}:
 *   get:
 *     summary: Retorna os posts de um usuário
 *     tags: [Posts]
 *     parameters:
 *       - in: path
 *         name: userId
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Lista de posts do usuário retornada com sucesso
 *       404:
 *         description: Usuário não encontrado
 *       500:
 *         description: Erro ao buscar posts do usuário
 */
router.get("/usuario/:userId", postController.getPostsByUser);

/**
 * @swagger
 * /api/posts/{postId}/like/{userId}:
 *   post:
 *     summary: Curte um post
 *     tags: [Posts]
 *     parameters:
 *       - in: path
 *         name: postId
 *         required: true
 *         schema:
 *           type: integer
 *       - in: path
 *         name: userId
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Post curtido com sucesso
 *       404:
 *         description: Post ou usuário não encontrado
 *       500:
 *         description: Erro ao curtir post
 */
router.post("/:postId/like/:userId", postController.likePost);

/**
 * @swagger
 * /api/posts/{postId}/unlike/{userId}:
 *   delete:
 *     summary: Descurte um post
 *     tags: [Posts]
 *     parameters:
 *       - in: path
 *         name: postId
 *         required: true
 *         schema:
 *           type: integer
 *       - in: path
 *         name: userId
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Post descurtido com sucesso
 *       404:
 *         description: Post ou usuário não encontrado
 *       500:
 *         description: Erro ao descurtir post
 */
router.delete("/:postId/unlike/:userId", postController.unlikePost);

/**
 * @swagger
 * /api/posts/{postId}/likes:
 *   get:
 *     summary: Retorna a quantidade de likes de um post
 *     tags: [Posts]
 *     parameters:
 *       - in: path
 *         name: postId
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Contagem de likes retornada com sucesso
 *       404:
 *         description: Post não encontrado
 *       500:
 *         description: Erro ao buscar contagem de likes
 */
router.get("/:postId/likes", postController.getLikesCount);
router.get("/", postController.getAllPosts);
router.get("/s", postController.getPostsByTitle);


/**
 * @swagger
 * /api/posts/startDate:
 *   get:
 *     summary: Retorna posts a partir de uma data inicial
 *     tags: [Posts]
 *     parameters:
 *       - in: query
 *         name: startDate
 *         required: true
 *         schema:
 *           type: string
 *           format: date-time
 *     responses:
 *       200:
 *         description: Lista de posts retornada com sucesso
 *       500:
 *         description: Erro ao buscar posts
 */
router.get("/startDate", postController.getPostsByStartDate);

/**
 * @swagger
 * /api/posts/{postId}:
 *   delete:
 *     summary: Deleta um post
 *     tags: [Posts]
 *     parameters:
 *       - in: path
 *         name: postId
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Post deletado com sucesso
 *       404:
 *         description: Post não encontrado
 *       500:
 *         description: Erro ao deletar post
 */
router.delete("/:postId", postController.deletePost);

module.exports = router;