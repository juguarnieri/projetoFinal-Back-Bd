const pool = require("../config/database");
const News = require("../models/newsModel");

const createNews = async (req, res) => {
  const { title, description, link, image, category } = req.body;

  if (!title || !link) {
    return res.status(400).json({
      error: "Campos obrigatórios ausentes.",
      details: "Os campos 'title' e 'link' são obrigatórios."
    });
  }

  try {
    const news = await News.create({ title, description, link, image, category });

    res.status(201).json({
      message: "Notícia criada com sucesso!",
      data: news
    });
  } catch (err) {
    console.error("Erro ao criar notícia:", err);
    res.status(500).json({
      error: "Erro interno ao criar notícia.",
      details: err.message
    });
  }
};

const getAllNews = async (req, res) => {
  try {
    const news = await News.findAll();

    res.status(200).json({
      message: "Lista de notícias recuperada com sucesso.",
      total: news.length,
      data: news
    });
  } catch (err) {
    console.error("Erro ao buscar notícias:", err);
    res.status(500).json({
      error: "Erro ao buscar notícias.",
      details: err.message
    });
  }
};

const getNewsByCategory = async (req, res) => {
  const { category } = req.params;

  try {
    const news = await News.getByCategory(category);

    res.status(200).json({
      message: `Notícias da categoria '${category}' recuperadas com sucesso.`,
      total: news.length,
      data: news
    });
  } catch (err) {
    console.error("Erro ao buscar por categoria:", err);
    res.status(500).json({
      error: "Erro ao buscar notícias por categoria.",
      details: err.message
    });
  }
};

const updateNews = async (req, res) => {
  const { id } = req.params;
  const data = req.body;

  try {
    const existing = await pool.query("SELECT * FROM news WHERE id = $1", [id]);

    if (existing.rowCount === 0) {
      return res.status(404).json({ error: "Notícia não encontrada." });
    }

    const updated = await News.update(id, data);

    res.status(200).json({
      message: "Notícia atualizada com sucesso.",
      data: updated
    });
  } catch (err) {
    console.error("Erro ao atualizar notícia:", err);
    res.status(500).json({
      error: "Erro ao atualizar notícia.",
      details: err.message
    });
  }
};

const deleteNews = async (req, res) => {
  const { id } = req.params;

  try {
    const result = await pool.query("DELETE FROM news WHERE id = $1 RETURNING *", [id]);

    if (result.rowCount === 0) {
      return res.status(404).json({ error: "Notícia não encontrada." });
    }

    res.status(200).json({
      message: "Notícia deletada com sucesso.",
      data: result.rows[0]
    });
  } catch (err) {
    console.error("Erro ao deletar notícia:", err);
    res.status(500).json({
      error: "Erro ao deletar notícia.",
      details: err.message
    });
  }
};

module.exports = {
  createNews,
  getAllNews,
  getNewsByCategory,
  updateNews,
  deleteNews
};
