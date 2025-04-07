const pool = require("../config/database");
const Podcast = require("../models/podcastModel");

const createPodcast = async (req, res) => {
  const { title, description, link, image, category } = req.body;

  if (!title || !link) {
    return res.status(400).json({
      error: "Campos obrigatórios ausentes.",
      details: "Os campos 'title' e 'link' são obrigatórios."
    });
  }

  try {
    const podcast = await Podcast.create({ title, description, link, image, category });

    res.status(201).json({
      message: "Podcast criado com sucesso!",
      data: podcast
    });
  } catch (err) {
    console.error("Erro ao criar podcast:", err);
    res.status(500).json({
      error: "Erro interno ao criar podcast.",
      details: err.message
    });
  }
};

const getAllPodcasts = async (req, res) => {
  try {
    const podcasts = await Podcast.findAll();

    res.status(200).json({
      message: "Lista de podcasts recuperada com sucesso.",
      total: podcasts.length,
      data: podcasts
    });
  } catch (err) {
    console.error("Erro ao buscar podcasts:", err);
    res.status(500).json({
      error: "Erro ao buscar podcasts.",
      details: err.message
    });
  }
};

const getPodcastsByCategory = async (req, res) => {
  const { category } = req.params;

  try {
    const podcasts = await Podcast.getByCategory(category);

    res.status(200).json({
      message: `Podcasts da categoria '${category}' recuperados com sucesso.`,
      total: podcasts.length,
      data: podcasts
    });
  } catch (err) {
    console.error("Erro ao buscar podcasts por categoria:", err);
    res.status(500).json({
      error: "Erro ao buscar podcasts por categoria.",
      details: err.message
    });
  }
};

const getPodcastById = async (req, res) => {
  const { id } = req.params;

  try {
    const podcast = await Podcast.findById(id);

    if (!podcast) {
      return res.status(404).json({ error: "Podcast não encontrado." });
    }

    res.status(200).json({
      message: "Podcast recuperado com sucesso.",
      data: podcast
    });
  } catch (err) {
    console.error("Erro ao buscar podcast por ID:", err);
    res.status(500).json({
      error: "Erro ao buscar podcast por ID.",
      details: err.message
    });
  }
};

const updatePodcast = async (req, res) => {
  const { id } = req.params;
  const data = req.body;

  try {
    const existing = await pool.query("SELECT * FROM podcasts WHERE id = $1", [id]);

    if (existing.rowCount === 0) {
      return res.status(404).json({ error: "Podcast não encontrado." });
    }

    const updated = await Podcast.update(id, data);

    res.status(200).json({
      message: "Podcast atualizado com sucesso.",
      data: updated
    });
  } catch (err) {
    console.error("Erro ao atualizar podcast:", err);
    res.status(500).json({
      error: "Erro ao atualizar podcast.",
      details: err.message
    });
  }
};

const deletePodcast = async (req, res) => {
  const { id } = req.params;

  try {
    const result = await pool.query("DELETE FROM podcasts WHERE id = $1 RETURNING *", [id]);

    if (result.rowCount === 0) {
      return res.status(404).json({ error: "Podcast não encontrado." });
    }

    res.status(200).json({
      message: "Podcast deletado com sucesso.",
      data: result.rows[0]
    });
  } catch (err) {
    console.error("Erro ao deletar podcast:", err);
    res.status(500).json({
      error: "Erro ao deletar podcast.",
      details: err.message
    });
  }
};

module.exports = {
  createPodcast,
  getAllPodcasts,
  getPodcastsByCategory,
  getPodcastById,
  updatePodcast,
  deletePodcast
};
