const pool = require("../config/database");
const Video = require("../models/videoModel");

const createVideo = async (req, res) => {
  const { title, description, link, image, category } = req.body;

  if (!title || !link) {
    return res.status(400).json({
      error: "Campos obrigatórios ausentes.",
      details: "Os campos 'title' e 'link' são obrigatórios."
    });
  }

  try {
    const video = await Video.create({ title, description, link, image, category });

    res.status(201).json({
      message: "Vídeo criado com sucesso!",
      data: video
    });
  } catch (err) {
    console.error("Erro ao criar vídeo:", err);
    res.status(500).json({
      error: "Erro interno ao criar vídeo.",
      details: err.message
    });
  }
};

const getAllVideos = async (req, res) => {
  try {
    const videos = await Video.findAll();

    res.status(200).json({
      message: "Lista de vídeos recuperada com sucesso.",
      total: videos.length,
      data: videos
    });
  } catch (err) {
    console.error("Erro ao buscar vídeos:", err);
    res.status(500).json({
      error: "Erro ao buscar vídeos.",
      details: err.message
    });
  }
};

const getVideosByCategory = async (req, res) => {
  const { category } = req.params;

  try {
    const videos = await Video.getByCategory(category);

    res.status(200).json({
      message: `Vídeos da categoria '${category}' recuperados com sucesso.`,
      total: videos.length,
      data: videos
    });
  } catch (err) {
    console.error("Erro ao buscar vídeos por categoria:", err);
    res.status(500).json({
      error: "Erro ao buscar vídeos por categoria.",
      details: err.message
    });
  }
};

const updateVideo = async (req, res) => {
  const { id } = req.params;
  const data = req.body;

  try {
    const existing = await pool.query("SELECT * FROM videos WHERE id = $1", [id]);

    if (existing.rowCount === 0) {
      return res.status(404).json({ error: "Vídeo não encontrado." });
    }

    const updated = await Video.update(id, data);

    res.status(200).json({
      message: "Vídeo atualizado com sucesso.",
      data: updated
    });
  } catch (err) {
    console.error("Erro ao atualizar vídeo:", err);
    res.status(500).json({
      error: "Erro ao atualizar vídeo.",
      details: err.message
    });
  }
};

const deleteVideo = async (req, res) => {
  const { id } = req.params;

  try {
    const result = await pool.query("DELETE FROM videos WHERE id = $1 RETURNING *", [id]);

    if (result.rowCount === 0) {
      return res.status(404).json({ error: "Vídeo não encontrado." });
    }

    res.status(200).json({
      message: "Vídeo deletado com sucesso.",
      data: result.rows[0]
    });
  } catch (err) {
    console.error("Erro ao deletar vídeo:", err);
    res.status(500).json({
      error: "Erro ao deletar vídeo.",
      details: err.message
    });
  }
};

const getVideoById = async (req, res) => {
  const { id } = req.params;

  try {
    const video = await Video.findById(id);

    if (!video) {
      return res.status(404).json({ error: "Vídeo não encontrado." });
    }

    res.status(200).json({
      message: "Vídeo recuperado com sucesso.",
      data: video
    });
  } catch (err) {
    console.error("Erro ao buscar vídeo por ID:", err);
    res.status(500).json({
      error: "Erro ao buscar vídeo por ID.",
      details: err.message
    });
  }
};

module.exports = {
  createVideo,
  getAllVideos,
  getVideosByCategory,
  updateVideo,
  deleteVideo,
  getVideoById
};
