const express = require("express");
const router = express.Router();
const postController = require("../controllers/postController");
const apiKeyMiddleware = require("../config/apiKey");

router.use(apiKeyMiddleware);
/**
 * @swagger
 * tags:
 *   name: Posts
 *   description: Endpoints para gerenciar e acessar posts
 */

/**
 * @swagger
 * /api/posts:
 *   get:
 *     summary: Lista todos os posts
 *     tags: [Posts]
 *     parameters:
 *       - in: query
 *         name: minLikes
 *         description: Filtro opcional para listar posts com um número mínimo de curtidas
 *         required: false
 *         schema:
 *           type: integer
 *       - in: query
 *         name: title
 *         description: Filtro opcional para buscar posts pelo título
 *         required: false
 *         schema:
 *           type: string
 *       - in: query
 *         name: startDate
 *         description: Filtro opcional para listar posts a partir de uma data específica (formato YYYY-MM-DD)
 *         required: false
 *         schema:
 *           type: string
 *           example: "2023-01-01"
 *     responses:
 *       200:
 *         description: Lista de posts
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "Lista de postagens recuperadas com sucesso"
 *                 total:
 *                   type: integer
 *                   example: 5
 *                 data:
 *                   type: array
 *                   items:
 *                     type: object
 *                     properties:
 *                       id:
 *                         type: integer
 *                         example: 1
 *                       user_id:
 *                         type: integer
 *                         example: 1
 *                       title:
 *                         type: string
 *                         example: "Meu Primeiro Post"
 *                       caption:
 *                         type: string
 *                         example: "Esse é o meu primeiro post na plataforma!"
 *                       media_url:
 *                         type: string
 *                         example: "http://example.com/image.jpg"
 *                       created_at:
 *                         type: string
 *                         format: date-time
 *                         example: "2023-05-12T10:00:00Z"
 *                       like_count:
 *                         type: integer
 *                         example: 10
 *       500:
 *         description: Erro ao buscar postagens
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Erro ao buscar postagens"
 *                 details:
 *                   type: string
 *                   example: "Erro ao consultar o banco de dados."
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
 *               - user_id
 *               - title
 *               - caption
 *               - media_url
 *             properties:
 *               user_id:
 *                 type: integer
 *                 description: ID do usuário que está criando o post
 *                 example: 1
 *               title:
 *                 type: string
 *                 description: Título do post
 *                 example: "Meu Primeiro Post"
 *               caption:
 *                 type: string
 *                 description: Descrição do post
 *                 example: "Esse é o meu primeiro post na plataforma!"
 *               media_url:
 *                 type: string
 *                 description: URL da mídia (imagem, vídeo) do post
 *                 example: "http://example.com/image.jpg"
 *     responses:
 *       201:
 *         description: Post criado com sucesso
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 id:
 *                   type: integer
 *                   example: 1
 *                 user_id:
 *                   type: integer
 *                   example: 1
 *                 title:
 *                   type: string
 *                   example: "Meu Primeiro Post"
 *                 caption:
 *                   type: string
 *                   example: "Esse é o meu primeiro post na plataforma!"
 *                 media_url:
 *                   type: string
 *                   example: "http://example.com/image.jpg"
 *       500:
 *         description: Erro ao criar post
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Erro ao criar post"
 */
router.post("/", postController.createPost);

/**
 * @swagger
 * /api/posts/user/{userId}:
 *   get:
 *     summary: Lista todos os posts de um usuário
 *     tags: [Posts]
 *     parameters:
 *       - in: path
 *         name: userId
 *         required: true
 *         description: ID do usuário
 *         schema:
 *           type: integer
 *           example: 1
 *     responses:
 *       200:
 *         description: Lista de posts do usuário
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
 *                   user_id:
 *                     type: integer
 *                     example: 1
 *                   title:
 *                     type: string
 *                     example: "Meu Primeiro Post"
 *                   caption:
 *                     type: string
 *                     example: "Esse é o meu primeiro post na plataforma!"
 *                   media_url:
 *                     type: string
 *                     example: "http://example.com/image.jpg"
 *                   created_at:
 *                     type: string
 *                     format: date-time
 *                     example: "2023-05-12T10:00:00Z"
 *       500:
 *         description: Erro ao buscar posts do usuário
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Erro ao buscar posts do usuário"
 */
router.get("/user/:userId", postController.getUserPosts);

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
 *         description: ID do post
 *         schema:
 *           type: integer
 *           example: 1
 *       - in: path
 *         name: userId
 *         required: true
 *         description: ID do usuário que está curtindo o post
 *         schema:
 *           type: integer
 *           example: 1
 *     responses:
 *       200:
 *         description: Post curtido com sucesso
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "Post curtido com sucesso"
 *       500:
 *         description: Erro ao curtir post
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Erro ao curtir post"
 */
router.post("/:postId/like/:userId", postController.likePost);

/**
 * @swagger
 * /api/posts/{postId}/unlike/{userId}:
 *   post:
 *     summary: Remove a curtida de um post
 *     tags: [Posts]
 *     parameters:
 *       - in: path
 *         name: postId
 *         required: true
 *         description: ID do post
 *         schema:
 *           type: integer
 *           example: 1
 *       - in: path
 *         name: userId
 *         required: true
 *         description: ID do usuário que está removendo a curtida
 *         schema:
 *           type: integer
 *           example: 1
 *     responses:
 *       200:
 *         description: Curtida removida com sucesso
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "Curtida removida com sucesso"
 *       500:
 *         description: Erro ao remover curtida
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Erro ao remover curtida"
 */
router.post('/:postId/unlike/:userId', postController.unlikePost);


/**
 * @swagger
 * /api/posts/{postId}/likes:
 *   get:
 *     summary: Retorna o número de curtidas de um post
 *     tags: [Posts]
 *     parameters:
 *       - in: path
 *         name: postId
 *         required: true
 *         description: ID do post
 *         schema:
 *           type: integer
 *           example: 1
 *     responses:
 *       200:
 *         description: Número de curtidas do post
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 likes:
 *                   type: integer
 *                   example: 10
 *       500:
 *         description: Erro ao contar curtidas
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Erro ao contar curtidas"
 */

router.get("/:postId/likes", postController.getLikesCount);

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
 *         description: ID do post a ser deletado
 *         schema:
 *           type: integer
 *           example: 1
 *     responses:
 *       200:
 *         description: Post deletado com sucesso
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "Post deletado com sucesso"
 *       404:
 *         description: Post não encontrado
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Post não encontrado"
 *       500:
 *         description: Erro ao deletar post
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Erro ao deletar post"
 */

router.delete("/:postId", postController.deletePost);

module.exports = router;