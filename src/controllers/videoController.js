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

module.exports = {
    //getAllVideos,
    //getByCategory,
    createVideo
};
