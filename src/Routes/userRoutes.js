const express = require("express");
const router = express.Router();
const userController = require("../controllers/userController");

/**
 * @swagger
 * tags:
 *   name: Users
 *   description: Operações relacionadas aos usuários
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
 *             required:
 *               - username
 *             properties:
 *               username:
 *                 type: string
 *                 example: "johndoe"
 *               name:
 *                 type: string
 *                 example: "John Doe"
 *               profile_picture:
 *                 type: string
 *                 example: "https://example.com/profile.jpg"
 *     responses:
 *       201:
 *         description: Usuário criado com sucesso
 */
router.post("/", userController.createUser);

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
 *                     example: "johndoe"
 *                   name:
 *                     type: string
 *                     example: "John Doe"
 *                   profile_picture:
 *                     type: string
 *                     example: "https://example.com/profile.jpg"
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
 *     responses:
 *       200:
 *         description: Perfil do usuário retornado com sucesso
 *       404:
 *         description: Usuário não encontrado
 */
router.get("/:id", userController.getUserById);

/**
 * @swagger
 * /api/users/{id}:
 *   put:
 *     summary: Atualiza o perfil de um usuário
 *     tags: [Users]
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
 *               username:
 *                 type: string
 *               name:
 *                 type: string
 *               profile_picture:
 *                 type: string
 *     responses:
 *       200:
 *         description: Usuário atualizado com sucesso
 *       404:
 *         description: Usuário não encontrado
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
 *     responses:
 *       200:
 *         description: Usuário deletado com sucesso
 *       404:
 *         description: Usuário não encontrado
 */
router.delete("/:id", userController.deleteUser);

/**
 * @swagger
 * /api/users/{id}/followers:
 *   get:
 *     summary: Lista os seguidores de um usuário
 *     tags: [Users]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Lista de seguidores retornada com sucesso
 */
router.get("/:id/followers", userController.getFollowers);

/**
 * @swagger
 * /api/users/{id}/following:
 *   get:
 *     summary: Lista os usuários seguidos por um usuário
 *     tags: [Users]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Lista de usuários seguidos retornada com sucesso
 */
router.get("/:id/following", userController.getFollowing);

/**
 * @swagger
 * /api/users/{id}/unfollow/{targetId}:
 *   delete:
 *     summary: Deixa de seguir um usuário
 *     tags: [Users]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *       - in: path
 *         name: targetId
 *         required: true
 *         schema:
 *           type: integer
 *     responses:
 *       200:
 *         description: Usuário deixou de seguir com sucesso
 *       400:
 *         description: Você não pode deixar de seguir a si mesmo
 *       404:
 *         description: Usuário não encontrado
 */
router.delete("/:id/unfollow/:targetId", userController.unfollowUser);

module.exports = router;
