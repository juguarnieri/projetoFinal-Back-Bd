const pool = require("../config/database");
const Podcast = require("../models/podcastModel");

const createPodcast = async (req, res) => {
    const { title, description, link, image, category } = req.body;

    if (!title || !link) {
        return res.status(400).json({ error: "Campos obrigatórios ausentes: title e link são obrigatórios." });
    }

    try {
        const podcast = await Podcast.create({ title, description, link, image, category });
        res.status(201).json(podcast);
    } catch (err) {
        console.error("Erro ao criar podcast:", err);
        res.status(500).json({ error: "Erro ao criar podcast", details: err.message });
    }
};

const getAllPodcasts = async (req, res) => {
    try {
        const podcasts = await Podcast.findAll();
        res.json(podcasts);
    } catch (err) {
        console.error("Erro ao buscar podcasts:", err);
        res.status(500).json({ error: "Erro ao buscar podcasts" });
    }
};



module.exports = {
    getAllPodcasts,
    //getByCategory,
    createPodcast
};
