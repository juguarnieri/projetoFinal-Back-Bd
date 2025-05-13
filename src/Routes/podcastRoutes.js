const express = require("express");
const router = express.Router();
const podcastController = require("../controllers/podcastController");
const apiKeyMiddleware = require("../config/apiKey");
const upload = require("../config/upload");

router.use(apiKeyMiddleware);

/**
 * @swagger
 * tags:
 *   name: Podcasts
 *   description: Endpoints para gerenciar e acessar podcasts
 */

/**
 * @swagger
 * /api/podcasts:
 *   get:
 *     summary: Lista todos os podcasts
 *     tags: [Podcasts]
 *     parameters:
 *       - in: query
 *         name: title
 *         schema:
 *           type: string
 *         description: Filtro pelo título do podcast
 *     responses:
 *       200:
 *         description: Lista de podcasts retornada com sucesso
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Podcast'
 *       500:
 *         description: Erro interno do servidor
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 status:
 *                   type: integer
 *                   example: 500
 *                 message:
 *                   type: string
 *                   example: Erro interno do servidor
 */
router.get("/", podcastController.getAllPodcasts);

/**
 * @swagger
 * /api/podcasts:
 *   post:
 *     summary: Cria um novo podcast
 *     tags: [Podcasts]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/PodcastInput'
 *     responses:
 *       201:
 *         description: Podcast criado com sucesso
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Podcast'
 *       400:
 *         description: Dados inválidos ou campos obrigatórios ausentes
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 status:
 *                   type: integer
 *                   example: 400
 *                 message:
 *                   type: string
 *                   example: Campos obrigatórios ausentes
 *       500:
 *         description: Erro ao criar podcast
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 status:
 *                   type: integer
 *                   example: 500
 *                 message:
 *                   type: string
 *                   example: Erro interno do servidor
 */
router.post("/", upload.single("image") , podcastController.createPodcast);

/**
 * @swagger
 * /api/podcasts/featured:
 *   get:
 *     summary: Lista de podcasts em destaque
 *     tags: [Podcasts]
 *     responses:
 *       200:
 *         description: Podcasts em destaque retornados com sucesso
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/Podcast'
 *       500:
 *         description: Erro interno do servidor
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 status:
 *                   type: integer
 *                   example: 500
 *                 message:
 *                   type: string
 *                   example: Erro interno do servidor
 */
router.get("/featured", podcastController.getFeaturedPodcasts);

/**
 * @swagger
 * /api/podcasts/{id}:
 *   get:
 *     summary: Obtém um podcast por ID
 *     tags: [Podcasts]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID do podcast
 *     responses:
 *       200:
 *         description: Podcast encontrado com sucesso
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Podcast'
 *       404:
 *         description: Podcast não encontrado
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 status:
 *                   type: integer
 *                   example: 404
 *                 message:
 *                   type: string
 *                   example: Podcast não encontrado
 *       500:
 *         description: Erro ao buscar podcast
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 status:
 *                   type: integer
 *                   example: 500
 *                 message:
 *                   type: string
 *                   example: Erro interno do servidor
 */
router.get("/:id", podcastController.getPodcastById);

/**
 * @swagger
 * /api/podcasts/{id}:
 *   put:
 *     summary: Atualiza um podcast existente
 *     tags: [Podcasts]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID do podcast
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             $ref: '#/components/schemas/PodcastInput'
 *     responses:
 *       200:
 *         description: Podcast atualizado com sucesso
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/Podcast'
 *       400:
 *         description: Dados inválidos enviados
 *       404:
 *         description: Podcast não encontrado
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 status:
 *                   type: integer
 *                   example: 404
 *                 message:
 *                   type: string
 *                   example: Podcast não encontrado
 *       500:
 *         description: Erro ao atualizar podcast
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 status:
 *                   type: integer
 *                   example: 500
 *                 message:
 *                   type: string
 *                   example: Erro interno do servidor
 */
router.put("/:id", podcastController.updatePodcast);

/**
 * @swagger
 * /api/podcasts/{id}:
 *   delete:
 *     summary: Remove um podcast pelo ID
 *     tags: [Podcasts]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID do podcast
 *     responses:
 *       200:
 *         description: Podcast deletado com sucesso
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: Podcast deletado com sucesso
 *       404:
 *         description: Podcast não encontrado
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 status:
 *                   type: integer
 *                   example: 404
 *                 message:
 *                   type: string
 *                   example: Podcast não encontrado
 *       500:
 *         description: Erro ao deletar podcast
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 status:
 *                   type: integer
 *                   example: 500
 *                 message:
 *                   type: string
 *                   example: Erro interno do servidor
 */
router.delete("/:id", podcastController.deletePodcast);

module.exports = router;