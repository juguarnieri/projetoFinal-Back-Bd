const pool = require("../config/database");
const News = require("../models/newsModel");
const createNews = async (req, res) => {
    const { title, description, link, image, category } = req.body;

    if (!link || !title) {
        return res.status(400).json({ error: "Campos obrigatórios ausentes: title e link são obrigatórios." });
    }

    try {
        const news = await News.create({ title, description, link, image, category });
        res.status(201).json(news);
    } catch (err) {
        console.error("Erro ao criar notícia:", err);
        res.status(500).json({ error: "Erro ao criar notícia", details: err.message });
    }
};

module.exports = {
    //getAllNews,
    //getByCategory,
    createNews
};
