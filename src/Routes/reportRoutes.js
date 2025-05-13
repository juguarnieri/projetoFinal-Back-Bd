const express = require("express");
const router = express.Router();
const reportController = require("../controllers/reportController");
const apiKeyMiddleware = require("../config/apiKey");

router.use(apiKeyMiddleware);
/**
 * @swagger
 * tags:
 *   name: Relatórios
 *   description: Endpoints para gerar relatórios em PDF
 */

/**
 * @swagger
 * /api/reports/users/pdf:
 *   get:
 *     summary: Exporta um relatório de usuários em PDF
 *     tags: [Relatórios]
 *     responses:
 *       200:
 *         description: Relatório de usuários gerado com sucesso em PDF
 *       404:
 *         description: Nenhum usuário encontrado para exportação
 *       500:
 *         description: Erro ao gerar PDF de usuários
 */
router.get("/users/pdf", reportController.exportUsersPDF);

/**
 * @swagger
 * /api/reports/posts/pdf:
 *   get:
 *     summary: Exporta um relatório de posts em PDF
 *     tags: [Relatórios]
 *     responses:
 *       200:
 *         description: Relatório de posts gerado com sucesso em PDF
 *       404:
 *         description: Nenhum post encontrado para exportação
 *       500:
 *         description: Erro ao gerar PDF de posts
 */
router.get("/posts/pdf", reportController.exportPostsPDF);

/**
 * @swagger
 * /api/reports/comments/pdf:
 *   get:
 *     summary: Exporta um relatório de comentários em PDF
 *     tags: [Relatórios]
 *     responses:
 *       200:
 *         description: Relatório de comentários gerado com sucesso em PDF
 *       404:
 *         description: Nenhum comentário encontrado para exportação
 *       500:
 *         description: Erro ao gerar PDF de comentários
 */
router.get("/comments/pdf", reportController.exportCommentsPDF);

/**
 * @swagger
 * /api/reports/news/pdf:
 *   get:
 *     summary: Exporta um relatório de notícias em PDF
 *     tags: [Relatórios]
 *     responses:
 *       200:
 *         description: Relatório de notícias gerado com sucesso em PDF
 *       404:
 *         description: Nenhuma notícia encontrada para exportação
 *       500:
 *         description: Erro ao gerar PDF de notícias
 */
router.get("/news/pdf", reportController.exportNewsPDF);

/**
 * @swagger
 * /api/reports/podcasts/pdf:
 *   get:
 *     summary: Exporta um relatório de podcasts em PDF
 *     tags: [Relatórios]
 *     responses:
 *       200:
 *         description: Relatório de podcasts gerado com sucesso em PDF
 *       404:
 *         description: Nenhum podcast encontrado para exportação
 *       500:
 *         description: Erro ao gerar PDF de podcasts
 */
router.get("/podcasts/pdf", reportController.exportPodcastsPDF);

/**
 * @swagger
 * /api/reports/videos/pdf:
 *   get:
 *     summary: Exporta um relatório de vídeos em PDF
 *     tags: [Relatórios]
 *     responses:
 *       200:
 *         description: Relatório de vídeos gerado com sucesso em PDF
 *       404:
 *         description: Nenhum vídeo encontrado para exportação
 *       500:
 *         description: Erro ao gerar PDF de vídeos
 */
router.get("/videos/pdf", reportController.exportVideosPDF);

/**
 * @swagger
 * /api/reports/about/pdf:
 *   get:
 *     summary: Exporta um relatório da página "Sobre Nós" e da equipe em PDF
 *     tags: [Relatórios]
 *     responses:
 *       200:
 *         description: Relatório da página "Sobre Nós" gerado com sucesso em PDF
 *       404:
 *         description: Página "Sobre Nós" ou equipe não encontrada para exportação
 *       500:
 *         description: Erro ao gerar PDF da página "Sobre Nós"
 */
router.get("/about/pdf", reportController.exportAboutPDF);

module.exports = router;
