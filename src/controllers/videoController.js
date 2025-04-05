const pool = require("../config/database");
const Video = require("../models/videoModel");

const createVideo = async (req, res) => {
    const { title, description, link, image, category } = req.body;

    if (!title || !link) {
        return res.status(400).json({ error: "Campos obrigatórios ausentes: title e link são obrigatórios." });
    }

    try {
        const video = await Video.create({ title, description, link, image, category });
        res.status(201).json(video);
    } catch (err) {
        console.error("Erro ao criar vídeo:", err);
        res.status(500).json({ error: "Erro ao criar vídeo", details: err.message });
    }
};
const getAllVideos = async (req, res) => {
    try {
        const videos = await Video.findAll();
        res.json(videos);
    } catch (err) {
        console.error("Erro ao buscar vídeos:", err);
        res.status(500).json({ error: "Erro ao buscar vídeos" });
    }
};
const getVideosByCategory = async (table, category) => {
    const result = await pool.query(
        `SELECT * FROM ${table} WHERE category ILIKE $1`,
        [category]
    );
    return result.rows;
};
const getByCategory = async (req, res) => {
    const { category } = req.params;

    try {
        const videos = await getVideosByCategory("videos", category);
        res.json(videos);
    } catch (err) {
        console.error("Erro ao buscar vídeos por categoria:", err);
        res.status(500).json({ error: "Erro ao buscar vídeos por categoria" });
    }
};

module.exports = {
    getAllVideos,
    getByCategory,
    createVideo
};
