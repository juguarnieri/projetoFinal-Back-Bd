const pool = require("../config/database");
const News = require("../models/newsModel");
const createNews = async (req, res) => {
    const { title, description, link, image, category } = req.body;

    if (!link || !title) {
        return res.status(400).json({ error: "Campos obrigatórios ausentes: title e link são obrigatórios." });
    }

    try {
        const news = await News.create({ title, description, link, image, category });
        res.status(201).json({
            message: "Notícia criada com sucesso",
            data: news
        });
    } catch (err) {
        console.error("Erro ao criar notícia:", err);
        res.status(500).json({ error: "Erro ao criar notícia", details: err.message });
    }
};

const getNewsByCategory = async (table, category) => {
    const result = await pool.query(
        `SELECT * FROM ${table} WHERE category ILIKE $1`,
        [category]
    );
    return result.rows;
};
const getAllNews = async (req, res) => {
    try {
        const news = await News.findAll();
        res.json(news);
    } catch (err) {
        console.error("Erro ao buscar notícias:", err);
        res.status(500).json({ error: "Erro ao buscar notícias" });
    }
};
const getByCategory = async (req, res) => {
    const { category } = req.params;

    try {
        const news = await getNewsByCategory("news", category);
        res.json(news);
    } catch (err) {
        console.error("Erro ao buscar por categoria:", err);
        res.status(500).json({ error: "Erro ao buscar notícias por categoria" });
    }
};

module.exports = {
    getAllNews,
    getByCategory,
    createNews
};
