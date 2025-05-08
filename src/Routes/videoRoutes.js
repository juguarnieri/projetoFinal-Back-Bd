const express = require("express");
const router = express.Router();
const videoController = require("../controllers/videoController");

/**
 * @swagger
 * tags:
 *   name: Videos
 *   description: Operações relacionadas aos vídeos
 */

/**
 * @swagger
 * /api/videos:
 *   post:
 *     summary: Cria um novo vídeo
 *     tags: [Videos]
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
 *               image:
 *                 type: string
 *               category:
 *                 type: string
 *     responses:
 *       201:
 *         description: Vídeo criado com sucesso
 */
router.post("/", videoController.createVideo);

/**
 * @swagger
 * /api/videos/category/{category}:
 *   get:
 *     summary: Retorna vídeos por categoria
 *     tags: [Videos]
 *     parameters:
 *       - in: path
 *         name: category
 *         required: true
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Lista de vídeos da categoria retornada com sucesso
 */
router.get("/category/:category", videoController.getVideosByCategory);

/**
 * @swagger
 * /api/videos/featured:
 *   get:
 *     summary: Retorna vídeos em destaque
 *     tags: [Videos]
 *     responses:
 *       200:
 *         description: Lista de vídeos em destaque retornada com sucesso
 */
router.get("/featured", videoController.getFeaturedVideos);

/**
 * @swagger
 * /api/videos/{id}:
 *   get:
 *     summary: Retorna um vídeo específico pelo ID
 *     tags: [Videos]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Vídeo encontrado com sucesso
 *       404:
 *         description: Vídeo não encontrado
 */
router.get("/:id", videoController.getVideoById);

/**
 * @swagger
 * /api/videos/{id}:
 *   put:
 *     summary: Atualiza um vídeo específico
 *     tags: [Videos]
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
 *               image:
 *                 type: string
 *               category:
 *                 type: string
 *     responses:
 *       200:
 *         description: Vídeo atualizado com sucesso
 *       404:
 *         description: Vídeo não encontrado
 */
router.put("/:id", videoController.updateVideo);

/**
 * @swagger
 * /api/videos/{id}:
 *   delete:
 *     summary: Deleta um vídeo específico
 *     tags: [Videos]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Vídeo deletado com sucesso
 *       404:
 *         description: Vídeo não encontrado
 */
router.delete("/:id", videoController.deleteVideo);

module.exports = router;