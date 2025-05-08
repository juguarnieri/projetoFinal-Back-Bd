const express = require("express");
const router = express.Router();
const aboutController = require("../controllers/aboutController");

router.get("/", aboutController.getAboutPage);

/**
 * @swagger
 * tags:
 *   name: About
 *   description: Página sobre nós e membros da equipe
 */

/**
 * @swagger
 * /api/about:
 *   post:
 *     summary: Cria o conteúdo da página "Sobre"
 *     tags: [About]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               main_title:
 *                 type: string
 *               subtitle:
 *                 type: string
 *               description:
 *                 type: string
 *               commitment_title:
 *                 type: string
 *               commitment_text:
 *                 type: string
 *     responses:
 *       201:
 *         description: Conteúdo criado
 */
router.post("/", aboutController.createAbout);

/**
 * @swagger
 * /api/about/{id}:
 *   put:
 *     summary: Atualiza o conteúdo da página "Sobre"
 *     tags: [About]
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
 *               main_title:
 *                 type: string
 *               subtitle:
 *                 type: string
 *               description:
 *                 type: string
 *               commitment_title:
 *                 type: string
 *               commitment_text:
 *                 type: string
 *     responses:
 *       200:
 *         description: Conteúdo atualizado
 */
router.put("/:id", aboutController.updateAbout);

/**
 * @swagger
 * /api/about/team:
 *   get:
 *     summary: Lista todos os membros da equipe
 *     tags: [About]
 *     parameters:
 *       - in: query
 *         name: name
 *         schema:
 *           type: string
 *         description: Filtro por nome
 *     responses:
 *       200:
 *         description: Lista de membros
 */
router.get("/team", aboutController.getAllMembers);

/**
 * @swagger
 * /api/about/team:
 *   post:
 *     summary: Cria um novo membro da equipe
 *     tags: [About]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               name:
 *                 type: string
 *               role:
 *                 type: string
 *               main_title:
 *                 type: string
 *               subtitle:
 *                 type: string
 *               description:
 *                 type: string
 *               commitment_title:
 *                 type: string
 *               commitment_text:
 *                 type: string
 *     responses:
 *       201:
 *         description: Membro criado
 */
router.post("/team", aboutController.addMember);

/**
 * @swagger
 * /api/about/team/{id}:
 *   get:
 *     summary: Busca um membro da equipe por ID
 *     tags: [About]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Membro encontrado
 *       404:
 *         description: Membro não encontrado
 */
router.get("/team/:id", aboutController.getMemberById);

/**
 * @swagger
 * /api/about/team/{id}:
 *   put:
 *     summary: Atualiza um membro da equipe
 *     tags: [About]
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
 *               name:
 *                 type: string
 *               role:
 *                 type: string
 *               main_title:
 *                 type: string
 *               subtitle:
 *                 type: string
 *               description:
 *                 type: string
 *               commitment_title:
 *                 type: string
 *               commitment_text:
 *                 type: string
 *     responses:
 *       200:
 *         description: Membro atualizado
 */
router.put("/team/:id", aboutController.updateMember);

/**
 * @swagger
 * /api/about/team/{id}:
 *   delete:
 *     summary: Deleta um membro da equipe
 *     tags: [About]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Membro deletado
 */
router.delete("/team/:id", aboutController.deleteMember);

module.exports = router;
