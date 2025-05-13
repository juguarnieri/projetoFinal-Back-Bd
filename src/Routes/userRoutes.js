const express = require("express");
const router = express.Router();
const userController = require("../controllers/userController");
const apiKeyMiddleware = require("../config/apiKey");
const upload = require("../config/upload");

router.use(apiKeyMiddleware);
/**
 * @swagger
 * tags:
 *   name: Users
 *   description: Endpoints para gerenciar usuários
 */

/**
 * @swagger
 * /api/users:
 *   post:
 *     summary: Cria um novo usuário
 *     tags: [Users]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               username:
 *                 type: string
 *                 example: "john_doe"
 *               name:
 *                 type: string
 *                 example: "John Doe"
 *               profile_picture:
 *                 type: string
 *                 example: "http://example.com/johndoe.jpg"
 *     responses:
 *       201:
 *         description: Usuário criado com sucesso
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 id:
 *                   type: integer
 *                   example: 1
 *                 username:
 *                   type: string
 *                   example: "john_doe"
 *                 name:
 *                   type: string
 *                   example: "John Doe"
 *                 profile_picture:
 *                   type: string
 *                   example: "http://example.com/johndoe.jpg"
 *       500:
 *         description: Erro ao criar usuário
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Erro ao criar usuário"
 */
router.post("/", upload.single("profile_picture") , userController.createUser);

/**
 * @swagger
 * /api/users:
 *   get:
 *     summary: Retorna todos os usuários
 *     tags: [Users]
 *     responses:
 *       200:
 *         description: Lista de usuários retornada com sucesso
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
 *                   username:
 *                     type: string
 *                     example: "john_doe"
 *                   name:
 *                     type: string
 *                     example: "John Doe"
 *                   profile_picture:
 *                     type: string
 *                     example: "http://example.com/johndoe.jpg"
 *       500:
 *         description: Erro ao buscar usuários
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Erro ao buscar usuários"
 */
router.get("/", userController.getAllUsers);

/**
 * @swagger
 * /api/users/{id}:
 *   get:
 *     summary: Retorna o perfil de um usuário
 *     tags: [Users]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID do usuário
 *     responses:
 *       200:
 *         description: Perfil do usuário encontrado com sucesso
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 id:
 *                   type: integer
 *                   example: 1
 *                 username:
 *                   type: string
 *                   example: "john_doe"
 *                 name:
 *                   type: string
 *                   example: "John Doe"
 *                 profile_picture:
 *                   type: string
 *                   example: "http://example.com/johndoe.jpg"
 *                 followers:
 *                   type: integer
 *                   example: 120
 *                 following:
 *                   type: integer
 *                   example: 85
 *                 likes:
 *                   type: integer
 *                   example: 300
 *       404:
 *         description: Usuário não encontrado
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Usuário não encontrado"
 *       500:
 *         description: Erro ao buscar perfil
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Erro ao buscar perfil"
 */
router.get("/:id", userController.getUserProfile);

/**
 * @swagger
 * /api/users/{id}:
 *   put:
 *     summary: Atualiza um usuário
 *     tags: [Users]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID do usuário a ser atualizado
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               username:
 *                 type: string
 *                 example: "john_doe_updated"
 *               name:
 *                 type: string
 *                 example: "John Doe Updated"
 *               profile_picture:
 *                 type: string
 *                 example: "http://example.com/johndoe_updated.jpg"
 *     responses:
 *       200:
 *         description: Usuário atualizado com sucesso
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "✅ Usuário atualizado com sucesso!"
 *                 user:
 *                   type: object
 *                   properties:
 *                     id:
 *                       type: integer
 *                       example: 1
 *                     username:
 *                       type: string
 *                       example: "john_doe_updated"
 *                     name:
 *                       type: string
 *                       example: "John Doe Updated"
 *                     profile_picture:
 *                       type: string
 *                       example: "http://example.com/johndoe_updated.jpg"
 *       404:
 *         description: Usuário não encontrado
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Usuário não encontrado"
 *       500:
 *         description: Erro ao atualizar usuário
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Erro ao atualizar usuário"
 */
router.put("/:id", userController.updateUser);

/**
 * @swagger
 * /api/users/{id}:
 *   delete:
 *     summary: Deleta um usuário
 *     tags: [Users]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID do usuário a ser deletado
 *     responses:
 *       200:
 *         description: Usuário deletado com sucesso
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "Usuário deletado com sucesso"
 *       404:
 *         description: Usuário não encontrado
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Usuário não encontrado"
 *       500:
 *         description: Erro ao deletar usuário
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Erro ao deletar usuário"
 */
router.delete("/:id", userController.deleteUser);

/**
 * @swagger
 * /api/users/{id}/follow/{targetId}:
 *   post:
 *     summary: Segue um usuário
 *     tags: [Users]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID do usuário que está seguindo
 *       - in: path
 *         name: targetId
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID do usuário a ser seguido
 *     responses:
 *       200:
 *         description: Usuário seguido com sucesso
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "Usuário seguido com sucesso"
 *       400:
 *         description: Erro ao seguir usuário (por exemplo, se o usuário tentar seguir a si mesmo ou já está seguindo)
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Você não pode seguir a si mesmo"
 *       500:
 *         description: Erro ao seguir usuário
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Erro ao seguir usuário"
 */
router.post("/:id/follow/:targetId", userController.followUser);

/**
 * @swagger
 * /api/users/{id}/unfollow/{targetId}:
 *   post:
 *     summary: Deixa de seguir um usuário
 *     tags: [Users]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID do usuário que está deixando de seguir
 *       - in: path
 *         name: targetId
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID do usuário a ser deixado de seguir
 *     responses:
 *       200:
 *         description: Usuário deixado de seguir com sucesso
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "Deixou de seguir com sucesso"
 *       500:
 *         description: Erro ao deixar de seguir
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Erro ao deixar de seguir"
 */
router.post("/:id/unfollow/:targetId", userController.unfollowUser);

module.exports = router;
