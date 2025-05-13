const express = require("express");
const router = express.Router();
const newsController = require("../controllers/newsController.js");
const apiKeyMiddleware = require("../config/apiKey.js");
const upload = require("../config/upload.js");

router.use(apiKeyMiddleware);

/**
 * @swagger
 * tags:
 *   name: News
 *   description: Endpoints para gerenciar e acessar notícias
 */

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
 *         description: Filtra notícias pelo título
 *       - in: query
 *         name: category
 *         schema:
 *           type: string
 *         description: Filtra notícias pela categoria
 *       - in: query
 *         name: year
 *         schema:
 *           type: integer
 *         description: Filtra notícias pelo ano
 *       - in: query
 *         name: decade
 *         schema:
 *           type: string
 *         description: Filtra notícias pela década
 *     responses:
 *       200:
 *         description: Lista de notícias retornada com sucesso
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "Lista de notícias recuperada com sucesso."
 *                 total:
 *                   type: integer
 *                   example: 10
 *                 data:
 *                   type: array
 *                   items:
 *                     type: object
 *                     properties:
 *                       id:
 *                         type: integer
 *                         example: 1
 *                       title:
 *                         type: string
 *                         example: "Notícia importante"
 *                       description:
 *                         type: string
 *                         example: "Descrição da notícia"
 *                       link:
 *                         type: string
 *                         example: "https://example.com/noticia"
 *                       category:
 *                         type: string
 *                         example: "Tecnologia"
 *                       year:
 *                         type: integer
 *                         example: 2025
 *       500:
 *         description: Erro interno do servidor
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Erro ao buscar notícias."
 *                 details:
 *                   type: string
 *                   example: "Erro no banco de dados."
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
 *                 description: Título da notícia
 *                 example: "Nova descoberta científica"
 *               description:
 *                 type: string
 *                 description: Descrição da notícia
 *                 example: "Pesquisadores descobriram uma nova espécie de planta."
 *               link:
 *                 type: string
 *                 description: Link da notícia
 *                 example: "https://example.com/noticia"
 *               image:
 *                 type: string
 *                 description: URL da imagem associada à notícia
 *                 example: "https://example.com/image.jpg"
 *               category:
 *                 type: string
 *                 description: Categoria da notícia
 *                 example: "Ciência"
 *               year:
 *                 type: integer
 *                 description: Ano da notícia
 *                 example: 2025
 *               is_featured:
 *                 type: boolean
 *                 description: Indica se a notícia é destacada
 *                 example: true
 *     responses:
 *       201:
 *         description: Notícia criada com sucesso
 *       400:
 *         description: Campos obrigatórios ausentes
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
 *                   example: ["title", "description", "link"]
 *       500:
 *         description: Erro interno ao criar notícia
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Erro interno ao criar notícia."
 *                 details:
 *                   type: string
 *                   example: "Erro ao inserir no banco de dados."
 */
router.post("/", upload.single("image") , newsController.createNews);
/**
 * @swagger
 * /api/news/featured:
 *   get:
 *     summary: Obtém notícias em destaque
 *     tags: [News]
 *     responses:
 *       200:
 *         description: Lista de notícias em destaque retornada com sucesso
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "Notícias em destaque recuperadas com sucesso."
 *                 data:
 *                   type: array
 *                   items:
 *                     type: object
 *                     properties:
 *                       id:
 *                         type: integer
 *                         example: 1
 *                       title:
 *                         type: string
 *                         example: "Notícia importante"
 */
router.get("/featured", newsController.getFeaturedNews);
/**
 * @swagger
 * /api/news/{id}:
 *   get:
 *     summary: Obtém uma notícia por ID
 *     tags: [News]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID da notícia
 *     responses:
 *       200:
 *         description: Notícia encontrada com sucesso
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "Notícia recuperada com sucesso."
 *                 data:
 *                   type: object
 *                   properties:
 *                     id:
 *                       type: integer
 *                       example: 1
 *                     title:
 *                       type: string
 *                       example: "Notícia importante"
 *       404:
 *         description: Notícia não encontrada
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Notícia não encontrada."
 *       500:
 *         description: Erro ao buscar notícia
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Erro ao buscar notícia."
 *                 details:
 *                   type: string
 *                   example: "Erro no banco de dados."
 */
router.get("/:id", newsController.getNewsById);


/**
 * @swagger
 * /api/news/{id}:
 *   put:
 *     summary: Atualiza uma notícia existente
 *     tags: [News]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID da notícia
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               title:
 *                 type: string
 *                 description: Título da notícia
 *               description:
 *                 type: string
 *                 description: Descrição da notícia
 *               link:
 *                 type: string
 *                 description: Link da notícia
 *               image:
 *                 type: string
 *                 description: URL da imagem associada à notícia
 *               category:
 *                 type: string
 *                 description: Categoria da notícia
 *               year:
 *                 type: integer
 *                 description: Ano da notícia
 *               is_featured:
 *                 type: boolean
 *                 description: Indica se a notícia é destacada
 *     responses:
 *       200:
 *         description: Notícia atualizada com sucesso
 *       404:
 *         description: Notícia não encontrada
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Notícia não encontrada."
 *       500:
 *         description: Erro ao atualizar notícia
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Erro ao atualizar notícia."
 *                 details:
 *                   type: string
 *                   example: "Erro no banco de dados."
 */
router.put("/:id", newsController.updateNews);
/**
 * @swagger
 * /api/news/{id}:
 *   delete:
 *     summary: Remove uma notícia pelo ID
 *     tags: [News]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID da notícia
 *     responses:
 *       200:
 *         description: Notícia deletada com sucesso
 *       404:
 *         description: Notícia não encontrada
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Notícia não encontrada."
 *       500:
 *         description: Erro ao deletar notícia
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Erro ao deletar notícia."
 *                 details:
 *                   type: string
 *                   example: "Erro ao acessar banco de dados."
 */
router.delete("/:id", newsController.deleteNews);


module.exports = router;