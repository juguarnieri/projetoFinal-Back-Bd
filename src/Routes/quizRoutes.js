const express = require("express");
const router = express.Router();
const quizController = require("../controllers/quizController");
const apiKeyMiddleware = require("../config/apiKey");

router.use(apiKeyMiddleware);

/**
 * @swagger
 * tags:
 *   name: Quiz
 *   description: Endpoints para responder e corrigir quizzes
 */

/**
 * @swagger
 * /api/quiz:
 *   get:
 *     summary: Lista todas as perguntas do quiz
 *     tags: [Quiz]
 *     description: Retorna todas as perguntas do quiz com suas alternativas (não mostra qual é a correta).
 *     responses:
 *       200:
 *         description: Lista de perguntas retornada com sucesso
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
 *                   question_text:
 *                     type: string
 *                     example: "Qual a capital do Brasil?"
 *                   alternatives:
 *                     type: array
 *                     items:
 *                       type: object
 *                       properties:
 *                         id:
 *                           type: integer
 *                           example: 10
 *                         alternative_text:
 *                           type: string
 *                           example: "Brasília"
 *       500:
 *         description: Erro ao buscar perguntas do quiz
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Erro ao buscar questões"
 */
router.get("/", quizController.getAllQuestions);

/**
 * @swagger
 * /api/quiz/submit:
 *   post:
 *     summary: Envia as respostas do quiz e retorna o resultado
 *     tags: [Quiz]
 *     description: Recebe as respostas do usuário e retorna o total de acertos.
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - answers
 *             properties:
 *               answers:
 *                 type: array
 *                 description: Lista de respostas do usuário
 *                 items:
 *                   type: object
 *                   properties:
 *                     question_id:
 *                       type: integer
 *                       example: 1
 *                     alternative_id:
 *                       type: integer
 *                       example: 10
 *     responses:
 *       200:
 *         description: Resultado do quiz
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 total:
 *                   type: integer
 *                   example: 20
 *                 correct:
 *                   type: integer
 *                   example: 17
 *       400:
 *         description: Formato de respostas inválido
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Formato de respostas inválido"
 *       500:
 *         description: Erro ao corrigir quiz
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Erro ao corrigir quiz"
 */
router.post("/submit", quizController.submitQuiz);

module.exports = router;