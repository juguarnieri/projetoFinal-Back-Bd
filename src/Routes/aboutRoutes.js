const express = require("express");
const router = express.Router();
const aboutController = require("../controllers/aboutController");

router.get("/", aboutController.getAboutPage);

/**
 * @swagger
 * tags:
 *   name: About
 *   description: Nossa página Sobre nós
 */

/**
 * @swagger
 * /api/about:
 *   get:
 *     summary: Lista todos os membros da nossa equipe
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


router.post("/", aboutController.createAbout);
router.put("/:id", aboutController.updateAbout);
router.get("/team", aboutController.getAllMembers);   
router.post("/team", aboutController.addMember);
router.put("/team/:id", aboutController.updateMember);
router.get("/team/:id", aboutController.getMemberById);
router.delete("/team/:id", aboutController.deleteMember);

module.exports = router;
