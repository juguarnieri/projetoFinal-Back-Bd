const postModel = require("../models/postModel");

const createPost = async (req, res) => {
    const { user_id, title, caption, media_url } = req.body;

    try {
        const post = await postModel.create({ user_id, title, caption, media_url });
        res.status(201).json(post);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Erro ao criar post" });
    }
};

module.exports = {
    createPost,
    //getUserPosts,
    //likePost,
    //unlikePost,
    //getLikesCount,
};
