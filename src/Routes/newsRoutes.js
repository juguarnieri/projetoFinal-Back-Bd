const express = require("express");
const router = express.Router();
const newsController = require("../controllers/newsController");

/**
 * @swagger
 * tags:
 *   name: News
 *   description: Operações relacionadas a notícias
 */

/**
 * @swagger
 * /api/news/featured:
 *   get:
 *     summary: Lista as notícias em destaque
 *     tags: [News]
 *     responses:
 *       200:
 *         description: Notícias em destaque retornadas com sucesso
 *       500:
 *         description: Erro ao buscar notícias em destaque
 */
router.get("/featured", newsController.getFeaturedNews);

/**
 * @swagger
 * /api/news/category/{category}:
 *   get:
 *     summary: Lista as notícias por categoria
 *     tags: [News]
 *     parameters:
 *       - in: path
 *         name: category
 *         required: true
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Notícias da categoria retornadas com sucesso
 *       500:
 *         description: Erro ao buscar notícias por categoria
 */
router.get("/category/:category", newsController.getNewsByCategory);

/**
 * @swagger
 * /api/news/decade/{decade}:
 *   get:
 *     summary: Lista as notícias por década
 *     tags: [News]
 *     parameters:
 *       - in: path
 *         name: decade
 *         required: true
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Notícias da década retornadas com sucesso
 *       500:
 *         description: Erro ao buscar notícias por década
 */
router.get("/decade/:decade", newsController.getNewsByDecade);

/**
 * @swagger
 * /api/news:
 *   get:
 *     summary: Lista todas as notícias
 *     tags: [News]
 *     parameters:
 *       - in: query
 *         name: title
 *         schema:
 *           type: string
 *         description: Filtro por título da notícia
 *     responses:
 *       200:
 *         description: Lista de notícias retornada com sucesso
 *       500:
 *         description: Erro ao buscar notícias
 */
router.get("/", newsController.getAllNews);

/**
 * @swagger
 * /api/news:
 *   post:
 *     summary: Cria uma nova notícia
 *     tags: [News]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - title
 *               - description
 *               - link
 *               - image
 *               - category
 *               - year
 *               - is_featured
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
 *               year:
 *                 type: integer
 *               is_featured:
 *                 type: boolean
 *     responses:
 *       201:
 *         description: Notícia criada com sucesso
 *       400:
 *         description: Campos obrigatórios ausentes
 *       500:
 *         description: Erro ao criar notícia
 */
router.post("/", newsController.createNews);

/**
 * @swagger
 * /api/news/{id}:
 *   put:
 *     summary: Atualiza uma notícia por ID
 *     tags: [News]
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
 *               year:
 *                 type: integer
 *               is_featured:
 *                 type: boolean
 *     responses:
 *       200:
 *         description: Notícia atualizada com sucesso
 *       404:
 *         description: Notícia não encontrada
 *       500:
 *         description: Erro ao atualizar notícia
 */
router.put("/:id", newsController.updateNews);

/**
 * @swagger
 * /api/news/{id}:
 *   delete:
 *     summary: Deleta uma notícia por ID
 *     tags: [News]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Notícia deletada com sucesso
 *       404:
 *         description: Notícia não encontrada
 *       500:
 *         description: Erro ao deletar notícia
 */
router.delete("/:id", newsController.deleteNews);

/**
 * @swagger
 * /api/news/{id}:
 *   get:
 *     summary: Recupera uma notícia por ID
 *     tags: [News]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Notícia recuperada com sucesso
 *       404:
 *         description: Notícia não encontrada
 *       500:
 *         description: Erro ao buscar notícia
 */
router.get("/:id", newsController.getNewsById);


module.exports = router;
