const express = require("express");
const router = express.Router();
const aboutController = require("../controllers/aboutController");
const apiKeyMiddleware = require("../config/apiKey"); // 🔐 Proteção com API Key

router.use(apiKeyMiddleware);

/**
 * @swagger
 * tags:
 *   name: About
 *   description: Endpoints para gerenciar a página "Sobre Nós" e membros da equipe
 */
/**
 * @swagger
 * /api/about:
 *   get:
 *     summary: Obtém a página "Sobre Nós" com os membros da equipe
 *     tags: [About]
 *     responses:
 *       200:
 *         description: Página "Sobre Nós" carregada com sucesso
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "Página 'Sobre Nós' carregada com sucesso."
 *                 data:
 *                   type: object
 *                   properties:
 *                     main_title:
 *                       type: string
 *                       example: "Nossa Empresa"
 *                     subtitle:
 *                       type: string
 *                       example: "Comprometimento com a excelência"
 *                     description:
 *                       type: string
 *                       example: "Somos uma empresa focada em inovação."
 *                     commitment_title:
 *                       type: string
 *                       example: "Nosso Compromisso"
 *                     commitment_text:
 *                       type: string
 *                       example: "Comprometidos em entregar soluções de qualidade."
 *                     team:
 *                       type: array
 *                       items:
 *                         type: object
 *                         properties:
 *                           id:
 *                             type: integer
 *                             example: 1
 *                           name:
 *                             type: string
 *                             example: "João Silva"
 *                           role:
 *                             type: string
 *                             example: "CEO"
 *                           photo_url:
 *                             type: string
 *                             example: "http://example.com/photo.jpg"
 *       500:
 *         description: Erro ao carregar página "Sobre Nós"
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Erro ao carregar dados."
 *                 details:
 *                   type: string
 *                   example: "Erro na consulta ao banco de dados."
 */
router.get("/", aboutController.getAboutPage);
/**
 * @swagger
 * /api/about/team:
 *   get:
 *     summary: Lista todos os membros da equipe
 *     tags: [About]
 *     parameters:
 *       - in: query
 *         name: name
 *         description: Filtra membros da equipe pelo nome (opcional)
 *         required: false
 *         schema:
 *           type: string
 *     responses:
 *       200:
 *         description: Lista de membros da equipe
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "Membros listados com sucesso."
 *                 data:
 *                   type: array
 *                   items:
 *                     type: object
 *                     properties:
 *                       id:
 *                         type: integer
 *                         example: 1
 *                       name:
 *                         type: string
 *                         example: "João Silva"
 *                       role:
 *                         type: string
 *                         example: "CEO"
 *                       photo_url:
 *                         type: string
 *                         example: "http://example.com/photo.jpg"
 *       500:
 *         description: Erro ao buscar membros
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Erro ao buscar membros."
 *                 details:
 *                   type: string
 *                   example: "Erro na consulta ao banco de dados."
 */
router.get("/team", aboutController.getAllMembers);

/**
 * @swagger
 * /api/about:
 *   post:
 *     summary: Cria uma nova página "Sobre Nós"
 *     tags: [About]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - main_title
 *               - subtitle
 *               - description
 *               - commitment_title
 *               - commitment_text
 *             properties:
 *               main_title:
 *                 type: string
 *                 description: Título principal da página
 *                 example: "Nossa Empresa"
 *               subtitle:
 *                 type: string
 *                 description: Subtítulo da página
 *                 example: "Comprometimento com a excelência"
 *               description:
 *                 type: string
 *                 description: Descrição da empresa
 *                 example: "Somos uma empresa focada em inovação."
 *               commitment_title:
 *                 type: string
 *                 description: Título do compromisso da empresa
 *                 example: "Nosso Compromisso"
 *               commitment_text:
 *                 type: string
 *                 description: Texto sobre o compromisso da empresa
 *                 example: "Comprometidos em entregar soluções de qualidade."
 *     responses:
 *       201:
 *         description: Página criada com sucesso
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "Página criada com sucesso."
 *                 data:
 *                   type: object
 *                   properties:
 *                     id:
 *                       type: integer
 *                       example: 1
 *                     main_title:
 *                       type: string
 *                       example: "Nossa Empresa"
 *                     subtitle:
 *                       type: string
 *                       example: "Comprometimento com a excelência"
 *                     description:
 *                       type: string
 *                       example: "Somos uma empresa focada em inovação."
 *                     commitment_title:
 *                       type: string
 *                       example: "Nosso Compromisso"
 *                     commitment_text:
 *                       type: string
 *                       example: "Comprometidos em entregar soluções de qualidade."
 *       400:
 *         description: Campos obrigatórios ausentes ou inválidos
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
 *                   example: ["main_title", "subtitle", "description", "commitment_title", "commitment_text"]
 *       500:
 *         description: Erro ao criar página "Sobre Nós"
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Erro ao criar página."
 *                 details:
 *                   type: string
 *                   example: "Erro ao inserir no banco de dados."
 */
router.post("/", aboutController.createAbout);



/**
 * @swagger
 * /api/about/{id}:
 *   put:
 *     summary: Atualiza a página "Sobre Nós" existente
 *     tags: [About]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID da página "Sobre Nós" a ser atualizada
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - main_title
 *               - subtitle
 *               - description
 *               - commitment_title
 *               - commitment_text
 *             properties:
 *               main_title:
 *                 type: string
 *                 description: Novo título principal
 *                 example: "Nossa Nova Empresa"
 *               subtitle:
 *                 type: string
 *                 description: Novo subtítulo
 *                 example: "Inovação e tecnologia"
 *               description:
 *                 type: string
 *                 description: Nova descrição
 *                 example: "Compromisso com a qualidade."
 *               commitment_title:
 *                 type: string
 *                 description: Novo título do compromisso
 *                 example: "Compromisso com a excelência"
 *               commitment_text:
 *                 type: string
 *                 description: Novo texto do compromisso
 *                 example: "Entregar o melhor para nossos clientes."
 *     responses:
 *       200:
 *         description: Página atualizada com sucesso
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "Página atualizada com sucesso."
 *                 data:
 *                   type: object
 *                   properties:
 *                     id:
 *                       type: integer
 *                       example: 1
 *                     main_title:
 *                       type: string
 *                       example: "Nossa Nova Empresa"
 *                     subtitle:
 *                       type: string
 *                       example: "Inovação e tecnologia"
 *                     description:
 *                       type: string
 *                       example: "Compromisso com a qualidade."
 *                     commitment_title:
 *                       type: string
 *                       example: "Compromisso com a excelência"
 *                     commitment_text:
 *                       type: string
 *                       example: "Entregar o melhor para nossos clientes."
 *       400:
 *         description: Campos obrigatórios ausentes ou inválidos
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
 *                   example: ["main_title", "subtitle", "description", "commitment_title", "commitment_text"]
 *       404:
 *         description: Página não encontrada
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Página não encontrada."
 *       500:
 *         description: Erro ao atualizar a página
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Erro ao atualizar a página."
 *                 details:
 *                   type: string
 *                   example: "Erro ao atualizar no banco de dados."
 */
router.put("/:id", aboutController.updateAbout);

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
 *             required:
 *               - name
 *               - role
 *               - photo_url
 *               - about_page_id
 *             properties:
 *               name:
 *                 type: string
 *                 description: Nome do membro
 *                 example: "João Silva"
 *               role:
 *                 type: string
 *                 description: Cargo do membro
 *                 example: "CEO"
 *               photo_url:
 *                 type: string
 *                 description: URL da foto do membro
 *                 example: "http://example.com/photo.jpg"
 *               about_page_id:
 *                 type: integer
 *                 description: ID da página "Sobre Nós" à qual o membro pertence
 *                 example: 1
 *     responses:
 *       201:
 *         description: Membro criado com sucesso
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "Membro adicionado com sucesso."
 *                 data:
 *                   type: object
 *                   properties:
 *                     id:
 *                       type: integer
 *                       example: 1
 *                     name:
 *                       type: string
 *                       example: "João Silva"
 *                     role:
 *                       type: string
 *                       example: "CEO"
 *                     photo_url:
 *                       type: string
 *                       example: "http://example.com/photo.jpg"
 *                     about_page_id:
 *                       type: integer
 *                       example: 1
 *       400:
 *         description: Campos obrigatórios ausentes ou inválidos
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
 *                   example: ["name", "role", "photo_url", "about_page_id"]
 *       500:
 *         description: Erro ao criar membro
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Erro ao criar membro."
 *                 details:
 *                   type: string
 *                   example: "Erro ao inserir no banco de dados."
 */
router.post("/team", aboutController.addMember);

/**
 * @swagger
 * /api/about/team/{id}:
 *   get:
 *     summary: Obtém um membro da equipe pelo ID
 *     tags: [About]
 *     parameters:
 *       - in: path
 *         name: id
 *         required: true
 *         schema:
 *           type: integer
 *         description: ID do membro da equipe
 *     responses:
 *       200:
 *         description: Membro encontrado com sucesso
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 message:
 *                   type: string
 *                   example: "Membro recuperado com sucesso."
 *                 data:
 *                   type: object
 *                   properties:
 *                     id:
 *                       type: integer
 *                       example: 1
 *                     name:
 *                       type: string
 *                       example: "João Silva"
 *                     role:
 *                       type: string
 *                       example: "CEO"
 *                     photo_url:
 *                       type: string
 *                       example: "http://example.com/photo.jpg"
 *       404:
 *         description: Membro não encontrado
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Membro não encontrado."
 *       500:
 *         description: Erro ao buscar membro
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Erro ao buscar membro."
 *                 details:
 *                   type: string
 *                   example: "Erro ao consultar o banco de dados."
 */
router.get("/team/:id", aboutController.getMemberById);

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
 *         description: ID do membro da equipe a ser removido
 *     responses:
 *       200:
 *         description: Membro removido com sucesso
 *       404:
 *         description: Membro não encontrado
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Membro não encontrado."
 *       500:
 *         description: Erro ao remover membro da equipe
 *         content:
 *           application/json:
 *             schema:
 *               type: object
 *               properties:
 *                 error:
 *                   type: string
 *                   example: "Erro ao remover membro."
 *                 details:
 *                   type: string
 *                   example: "Erro ao deletar do banco de dados."
 */
router.delete("/team/:id", aboutController.deleteMember);



module.exports = router;
