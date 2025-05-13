const express = require("express");
const router = express.Router();
const videoController = require("../controllers/videoController");
const apiKeyMiddleware = require("../config/apiKey");
const upload = require("../config/upload");

router.use(apiKeyMiddleware);
/**
 * @swagger
 * tags:
 *   name: Vídeos
 *   description: Endpoints para gerenciar vídeos
 */

/**
 * @swagger
 * /api/videos:
 *   post:
 *     summary: Cria um novo vídeo
 *     tags: [Vídeos]
 *     description: Cria um vídeo no sistema. Os campos "title" e "link" são obrigatórios.
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
 *                 example: "Introdução ao Node.js"
 *               description:
 *                 type: string
 *                 example: "Explicação dos fundamentos do Node.js"
 *               link:
 *                 type: string
 *                 example: "https://youtube.com/watch?v=abc123"
 *               image:
 *                 type: string
 *                 example: "https://example.com/thumb.jpg"
 *               category:
 *                 type: string
 *                 example: "Tecnologia"
 *               is_featured:
 *                 type: boolean
 *                 example: true
 *     responses:
 *       201:
 *         description: Vídeo criado com sucesso
 *         content:
 *           application/json:
 *             example:
 *               message: "Vídeo criado com sucesso!"
 *               data:
 *                 id: 1
 *                 title: "Introdução ao Node.js"
 *                 description: "Explicação dos fundamentos do Node.js"
 *                 link: "https://youtube.com/watch?v=abc123"
 *                 image: "https://example.com/thumb.jpg"
 *                 category: "Tecnologia"
 *                 is_featured: true
 *       400:
 *         description: Campos obrigatórios ausentes
 *         content:
 *           application/json:
 *             example:
 *               error: "Campos obrigatórios ausentes."
 *               details: "Os campos title e link são obrigatórios."
 *       500:
 *         description: Erro interno ao criar vídeo
 *         content:
 *           application/json:
 *             example:
 *               error: "Erro interno ao criar vídeo."
 *               details: "Detalhes técnicos do erro"
 */
router.post("/", upload.single("image") , videoController.createVideo);

/**
 * @swagger
 * /api/videos/category/{category}:
 *   get:
 *     summary: Retorna vídeos filtrados por categoria
 *     tags: [Vídeos]
 *     parameters:
 *       - in: path
 *         name: category
 *         required: true
 *         schema:
 *           type: string
 *         description: Categoria para filtro (case insensitive)
 *     responses:
 *       200:
 *         description: Vídeos da categoria retornados com sucesso
 *         content:
 *           application/json:
 *             example:
 *               message: "Vídeos da categoria Tecnologia recuperados com sucesso."
 *               total: 5
 *               data:
 *                 - id: 1
 *                   title: "Introdução ao Node.js"
 *                   description: "Explicação dos fundamentos do Node.js"
 *                   link: "https://youtube.com/watch?v=abc123"
 *                   image: "https://example.com/thumb.jpg"
 *                   category: "Tecnologia"
 *                   is_featured: false
 *                   created_at: "2024-01-01T00:00:00Z"
 *                 - id: 2
 *                   title: "JavaScript Avançado"
 *                   description: "Abordagem de técnicas avançadas de JS"
 *                   link: "https://youtube.com/watch?v=def456"
 *                   image: "https://example.com/thumb2.jpg"
 *                   category: "Tecnologia"
 *                   is_featured: true
 *                   created_at: "2024-02-01T00:00:00Z"
 *       500:
 *         description: Erro ao buscar vídeos por categoria
 *         content:
 *           application/json:
 *             example:
 *               error: "Erro ao buscar vídeos por categoria."
 *               details: "Mensagem de erro"
 */
router.get("/category/:category", videoController.getVideosByCategory);

/**
 * @swagger
 * /api/videos/featured:
 *   get:
 *     summary: Lista todos os vídeos marcados como destaque
 *     tags: [Vídeos]
 *     description: Retorna vídeos onde `is_featured = true`, ordenados por data de criação.
 *     responses:
 *       200:
 *         description: Lista de vídeos em destaque retornada com sucesso
 *         content:
 *           application/json:
 *             example:
 *               message: "Vídeos em destaque recuperados com sucesso."
 *               total: 3
 *               data:
 *                 - id: 1
 *                   title: "Introdução ao Node.js"
 *                   description: "Explicação dos fundamentos do Node.js"
 *                   link: "https://youtube.com/watch?v=abc123"
 *                   image: "https://example.com/thumb.jpg"
 *                   category: "Tecnologia"
 *                   is_featured: true
 *                   created_at: "2024-01-01T00:00:00Z"
 *                 - id: 2
 *                   title: "JavaScript Avançado"
 *                   description: "Abordagem de técnicas avançadas de JS"
 *                   link: "https://youtube.com/watch?v=def456"
 *                   image: "https://example.com/thumb2.jpg"
 *                   category: "Tecnologia"
 *                   is_featured: true
 *                   created_at: "2024-02-01T00:00:00Z"
 *       500:
 *         description: Erro ao buscar vídeos em destaque
 *         content:
 *           application/json:
 *             example:
 *               error: "Erro ao buscar vídeos em destaque."
 *               details: "Mensagem técnica"
 */
router.get("/featured", videoController.getFeaturedVideos);

/**
 * @swagger
 * /api/videos/{id}:
 *   get:
 *     summary: Retorna um vídeo específico por ID
 *     tags: [Vídeos]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID do vídeo
 *     responses:
 *       200:
 *         description: Vídeo encontrado com sucesso
 *         content:
 *           application/json:
 *             example:
 *               message: "Vídeo recuperado com sucesso."
 *               data:
 *                 id: 1
 *                 title: "Exemplo"
 *                 description: "Descrição do vídeo"
 *                 link: "https://youtube.com/watch?v=abc123"
 *                 image: "https://example.com/thumb.jpg"
 *                 category: "Tecnologia"
 *                 is_featured: true
 *                 created_at: "2024-01-01T00:00:00Z"
 *       404:
 *         description: Vídeo não encontrado
 *         content:
 *           application/json:
 *             example:
 *               error: "Vídeo não encontrado."
 *       500:
 *         description: Erro ao buscar vídeo por ID
 *         content:
 *           application/json:
 *             example:
 *               error: "Erro ao buscar vídeo por ID."
 *               details: "Mensagem técnica"
 */
router.get("/:id", videoController.getVideoById);

/**
 * @swagger
 * /api/videos/{id}:
 *   put:
 *     summary: Atualiza um vídeo existente
 *     tags: [Vídeos]
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
 *               is_featured:
 *                 type: boolean
 *     responses:
 *       200:
 *         description: Vídeo atualizado com sucesso
 *         content:
 *           application/json:
 *             example:
 *               message: "Vídeo atualizado com sucesso."
 *               data:
 *                 id: 1
 *                 title: "Novo Título"
 *                 description: "Nova descrição"
 *                 link: "https://youtube.com/watch?v=xyz456"
 *                 image: "https://example.com/newthumb.jpg"
 *                 category: "Tecnologia"
 *                 is_featured: false
 *                 created_at: "2024-01-01T00:00:00Z"
 *       404:
 *         description: Vídeo não encontrado
 *         content:
 *           application/json:
 *             example:
 *               error: "Vídeo não encontrado."
 *       500:
 *         description: Erro ao atualizar vídeo
 *         content:
 *           application/json:
 *             example:
 *               error: "Erro ao atualizar vídeo."
 *               details: "Erro técnico"
 */
router.put("/:id", videoController.updateVideo);

/**
 * @swagger
 * /api/videos:
 *   get:
 *     summary: Retorna todos os vídeos
 *     tags: [Vídeos]
 *     description: Retorna todos os vídeos cadastrados. Pode-se filtrar por título via query string.
 *     parameters:
 *       - in: query
 *         name: title
 *         schema:
 *           type: string
 *         description: Título parcial ou completo do vídeo
 *     responses:
 *       200:
 *         description: Lista de vídeos retornada com sucesso
 *         content:
 *           application/json:
 *             example:
 *               - id: 1
 *                 title: "Vídeo Exemplo"
 *                 description: "Descrição do vídeo"
 *                 link: "https://youtube.com/watch?v=abc123"
 *                 image: "https://example.com/thumb.jpg"
 *                 category: "Tecnologia"
 *                 is_featured: false
 *                 created_at: "2024-01-01T00:00:00Z"
 *       500:
 *         description: Erro ao buscar vídeos
 *         content:
 *           application/json:
 *             example:
 *               error: "Erro ao buscar vídeos."
 *               details: "Detalhes técnicos do erro"
 */
router.get("/", videoController.getAllVideos);

/**
 * @swagger
 * /api/videos/{id}:
 *   delete:
 *     summary: Remove um vídeo por ID
 *     tags: [Vídeos]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Vídeo deletado com sucesso
 *         content:
 *           application/json:
 *             example:
 *               message: "Vídeo deletado com sucesso."
 *               data:
 *                 id: 1
 *                 title: "Deletado"
 *                 description: "Vídeo excluído do sistema"
 *                 link: "https://youtube.com/watch?v=abc123"
 *                 image: "https://example.com/thumb.jpg"
 *                 category: "Tecnologia"
 *                 is_featured: false
 *                 created_at: "2024-01-01T00:00:00Z"
 *       404:
 *         description: Vídeo não encontrado
 *         content:
 *           application/json:
 *             example:
 *               error: "Vídeo não encontrado."
 *       500:
 *         description: Erro ao deletar vídeo
 *         content:
 *           application/json:
 *             example:
 *               error: "Erro ao deletar vídeo."
 *               details: "Erro técnico"
 */
router.delete("/:id", videoController.deleteVideo);

module.exports = router;
