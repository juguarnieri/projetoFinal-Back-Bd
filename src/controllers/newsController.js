const pool = require("../config/database");
const News = require("../models/newsModel");

function extractDecadeFromYear(year) {
  if (!year) return null;
  const decade = Math.floor(year / 10) * 10;
  return decade.toString().slice(2);
}

const createNews = async (req, res) => {
  const { title, description, text, link, category, is_featured, year } = req.body;

  const requiredFields = ['title', 'description', 'text', 'link', 'category', 'year', 'is_featured'];
  const missingFields = requiredFields.filter(field => req.body[field] === undefined);

  if (missingFields.length > 0) {
    return res.status(400).json({
      error: "Campos obrigatórios ausentes.",
      missing_fields: missingFields
    });
  }

  try {
    const decade = extractDecadeFromYear(year);
    const image = req.file ? req.file.filename : null;
    const news = await News.create({
      title,
      description,
      text,
      link,
      image,
      category,
      is_featured,
      year,
      decade
    });

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
  const { title, year, decade, category } = req.query;

  try {
    let news;
    if (title) news = await News.getByTitle(title);
    else if (year) news = await News.getByYear(year);
    else if (decade) news = await News.getByDecade(decade);
    else if (category) news = await News.getByCategory(category);
    else news = await News.findAll();

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

const getNewsByYear = async (req, res) => {
  const { year } = req.params;

  try {
    const news = await News.getByYear(year);

    res.status(200).json({
      message: `Notícias do ano de ${year} recuperadas com sucesso.`,
      total: news.length,
      data: news
    });
  } catch (err) {
    console.error("Erro ao buscar notícias por ano:", err);
    res.status(500).json({
      error: "Erro ao buscar notícias por ano.",
      details: err.message
    });
  }
};

const getNewsByDecade = async (req, res) => {
  const { decade } = req.params;

  try {
    const news = await News.getByDecade(decade);

    res.status(200).json({
      message: `Notícias da década de ${decade} recuperadas com sucesso.`,
      total: news.length,
      data: news
    });
  } catch (err) {
    console.error("Erro ao buscar notícias por década:", err);
    res.status(500).json({
      error: "Erro ao buscar notícias por década.",
      details: err.message
    });
  }
};

const updateNews = async (req, res) => {
  const { id } = req.params;
  const { title, description, text, link, image, category, is_featured, year } = req.body;

  try {
    const decade = extractDecadeFromYear(year);
    const updatedNews = await News.update(parseInt(id, 10), {
      title,
      description,
      text,
      link,
      image,
      category,
      is_featured,
      year,
      decade
    });

    if (!updatedNews) {
      return res.status(404).json({ error: "Notícia não encontrada." });
    }

    res.status(200).json({
      message: "Notícia atualizada com sucesso.",
      data: updatedNews
    });
  } catch (error) {
    console.error("Erro ao atualizar notícia:", error);
    res.status(500).json({
      error: "Erro ao atualizar notícia.",
      details: error.message
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

const getNewsById = async (req, res) => {
  const { id } = req.params;

  if (isNaN(id)) {
    return res.status(400).json({ error: "ID inválido." });
  }

  try {
    const news = await News.findById(id);

    if (!news) {
      return res.status(404).json({ error: "Notícia não encontrada." });
    }

    res.status(200).json({
      message: "Notícia recuperada com sucesso.",
      data: news
    });
  } catch (error) {
    console.error("Erro ao buscar notícia por ID:", error);
    res.status(500).json({
      error: "Erro ao buscar notícia por ID.",
      details: error.message
    });
  }
};

const getFeaturedNews = async (req, res) => {
  try {
    const featuredNews = await News.getFeatured();
    res.status(200).json({
      message: "Notícias em destaque recuperadas com sucesso.",
      data: featuredNews
    });
  } catch (error) {
    console.error("Erro ao buscar notícias em destaque:", error);
    res.status(500).json({
      error: "Erro ao buscar notícias em destaque.",
      details: error.message
    });
  }
};

module.exports = {
  createNews,
  getAllNews,
  getNewsByCategory,
  getNewsByYear,
  getNewsByDecade,
  updateNews,
  deleteNews,
  getNewsById,
  getFeaturedNews,
};
