const express = require("express");
const router = express.Router();
const podcastController = require("../controllers/podcastController");

/**
 * @swagger
 * tags:
 *   name: Podcasts
 *   description: Operações relacionadas aos podcasts
 */

/**
 * @swagger
 * /api/podcasts:
 *   get:
 *     summary: Retorna todos os podcasts
 *     tags: [Podcasts]
 *     responses:
 *       200:
 *         description: Lista de podcasts retornada com sucesso
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
 *                     example: "Podcast sobre tecnologia"
 *                   description:
 *                     type: string
 *                     example: "Discussões sobre o futuro da tecnologia."
 *                   link:
 *                     type: string
 *                     example: "https://example.com/podcast"
 *                   category:
 *                     type: string
 *                     example: "Tecnologia"
 *                   image:
 *                     type: string
 *                     example: "https://example.com/image.jpg"
 *       500:
 *         description: Erro interno do servidor
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
 *             type: object
 *             required:
 *               - title
 *               - link
 *             properties:
 *               title:
 *                 type: string
 *               description:
 *                 type: string
 *               link:
 *                 type: string
 *               category:
 *                 type: string
 *               image:
 *                 type: string
 *     responses:
 *       201:
 *         description: Podcast criado com sucesso
 *       500:
 *         description: Erro ao criar podcast
 */
router.post("/", podcastController.createPodcast);

/**
 * @swagger
 * /api/podcasts/{id}:
 *   get:
 *     summary: Retorna um podcast específico pelo ID
 *     tags: [Podcasts]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Podcast encontrado
 *       404:
 *         description: Podcast não encontrado
 *       500:
 *         description: Erro ao buscar podcast
 */
router.get("/:id", podcastController.getPodcastById);

/**
 * @swagger
 * /api/podcasts/{id}:
 *   put:
 *     summary: Atualiza um podcast específico
 *     tags: [Podcasts]
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
 *             properties:
 *               title:
 *                 type: string
 *               description:
 *                 type: string
 *               link:
 *                 type: string
 *               category:
 *                 type: string
 *               image:
 *                 type: string
 *     responses:
 *       200:
 *         description: Podcast atualizado com sucesso
 *       404:
 *         description: Podcast não encontrado
 *       500:
 *         description: Erro ao atualizar podcast
 */
router.put("/:id", podcastController.updatePodcast);

/**
 * @swagger
 * /api/podcasts/{id}:
 *   delete:
 *     summary: Deleta um podcast
 *     tags: [Podcasts]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Podcast deletado com sucesso
 *       404:
 *         description: Podcast não encontrado
 *       500:
 *         description: Erro ao deletar podcast
 */
router.delete("/:id", podcastController.deletePodcast);

/**
 * @swagger
 * /api/podcasts/featured:
 *   get:
 *     summary: Retorna podcasts em destaque
 *     tags: [Podcasts]
 *     responses:
 *       200:
 *         description: Lista de podcasts em destaque retornada com sucesso
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
 *                     example: "Podcast sobre tecnologia"
 *                   description:
 *                     type: string
 *                     example: "Discussões sobre o futuro da tecnologia."
 *                   link:
 *                     type: string
 *                     example: "https://example.com/podcast"
 *                   category:
 *                     type: string
 *                     example: "Tecnologia"
 *                   image:
 *                     type: string
 *                     example: "https://example.com/image.jpg"
 *       500:
 *         description: Erro interno do servidor
 */
router.get("/featured", podcastController.getFeaturedPodcasts);

module.exports = router;
