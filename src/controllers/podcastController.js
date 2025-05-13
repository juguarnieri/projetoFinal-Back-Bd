const Podcast = require("../models/podcastModel");

const createPodcast = async (req, res) => {
    try {
        const { title, description, link, image, category, is_featured } = req.body;

        if (!title || !link) {
            return res.status(400).json({
                error: "Campos obrigatórios ausentes.",
                details: "Os campos 'title' e 'link' são obrigatórios."
            });
        }

        const podcast = await Podcast.create({ title, description, link, image, category, is_featured });
        
        res.status(201).json({
            message: "Podcast criado com sucesso!",
            data: podcast
        });
    } catch (err) {
        console.error("Erro ao criar podcast:", err);
        res.status(500).json({ error: "Erro interno.", details: err.message });
    }
};

const getAllPodcasts = async (req, res) => {
  try {
    const { title } = req.query;
    console.log("🎶 Valor recebido de 'title':", title);

    const podcasts = await Podcast.findAll(title); 

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
    try {
        const { category } = req.params;
        const podcasts = await Podcast.getByCategory(category);

        res.status(200).json({
            message: `Podcasts da categoria '${category}' recuperados com sucesso.`,
            total: podcasts.length,
            data: podcasts
        });
    } catch (err) {
        console.error("Erro ao buscar podcasts por categoria:", err);
        res.status(500).json({ error: "Erro interno.", details: err.message });
    }
};

const getFeaturedPodcasts = async (req, res) => {
    try {
        const podcasts = await Podcast.getFeatured();

        res.status(200).json({
            message: "Podcasts em destaque recuperados com sucesso.",
            total: podcasts.length,
            data: podcasts
        });
    } catch (err) {
        console.error("Erro ao buscar podcasts em destaque:", err);
        res.status(500).json({ error: "Erro interno.", details: err.message });
    }
};

const getPodcastById = async (req, res) => {
    try {
        const { id } = req.params;
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
        res.status(500).json({ error: "Erro interno.", details: err.message });
    }
};

const updatePodcast = async (req, res) => {
    try {
        const { id } = req.params;
        const data = req.body;

        const podcast = await Podcast.findById(id);
        if (!podcast) {
            return res.status(404).json({ error: "Podcast não encontrado." });
        }

        const updated = await Podcast.update(id, data);

        res.status(200).json({
            message: "Podcast atualizado com sucesso.",
            data: updated
        });
    } catch (err) {
        console.error("Erro ao atualizar podcast:", err);
        res.status(500).json({ error: "Erro interno.", details: err.message });
    }
};

const deletePodcast = async (req, res) => {
    try {
        const { id } = req.params;
        const deleted = await Podcast.remove(id);

        if (!deleted) {
            return res.status(404).json({ error: "Podcast não encontrado." });
        }

        res.status(200).json({
            message: "Podcast deletado com sucesso.",
            data: deleted
        });
    } catch (err) {
        console.error("Erro ao deletar podcast:", err);
        res.status(500).json({ error: "Erro interno.", details: err.message });
    }
};

module.exports = {
    createPodcast,
    getAllPodcasts,
    getPodcastsByCategory,
    getFeaturedPodcasts,
    getPodcastById,
    updatePodcast,
    deletePodcast
};
