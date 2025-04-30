const pool = require("../config/database");

const getAllPosts = async (minLikes = 0) => {
    if (minLikes === 0) {
    const result = await pool.query(`
        SELECT 
            posts.id,
            posts.user_id,
            posts.title,
            posts.caption,
            posts.media_url,
            posts.created_at,
            COUNT(likes.id) AS like_count
        FROM posts
        LEFT JOIN likes ON posts.id = likes.post_id
        GROUP BY posts.id
        HAVING COUNT(likes.id) >= $1
        ORDER BY posts.created_at DESC
    `, [minLikes]);
    return result.rows;
    }
};
const create = async ({ user_id, title, caption, media_url }) => {
    const result = await pool.query(
        "INSERT INTO posts (user_id, title, caption, media_url) VALUES ($1, $2, $3, $4) RETURNING *",
        [user_id, title, caption, media_url]
    );
    return result.rows[0];
};
const findByUser = async (user_id) => {
    const result = await pool.query("SELECT * FROM posts WHERE user_id = $1", [user_id]);
    return result.rows;
};
const like = async (user_id, post_id) => {
    try {
        await pool.query(
            "INSERT INTO likes (user_id, post_id) VALUES ($1, $2) ON CONFLICT DO NOTHING",
            [user_id, post_id]
        );
    } catch (err) {
        console.error("Erro ao curtir:", err);
        throw err;
    }
};
const unlike = async (user_id, post_id) => {
    await pool.query("DELETE FROM likes WHERE user_id = $1 AND post_id = $2", [user_id, post_id]);
};
const countLikes = async (post_id) => {
    const result = await pool.query(
        "SELECT COUNT(*) FROM likes WHERE post_id = $1",
        [post_id]
    );
    return parseInt(result.rows[0].count);
};
const getPostsTitle = async (title) => {
    try {
        if (!title) {
            const result = await pool.query("SELECT * FROM posts");
            return result.rows;
        }else {
            const result = await pool.query("SELECT * FROM posts WHERE LOWER(title) LIKE LOWER($1)", [title]);
            return result.rows;
        }
    } catch (err) {
        console.error("Erro ao buscar posts:", err);
        throw err;
    }
};
const deletePost = async (postId) => {
    const result = await pool.query("DELETE FROM posts WHERE id = $1", [postId]);
    return result.rowCount > 0; 
};



module.exports = {
    getAllPosts,
    create,
    findByUser,
    like,
    unlike,
    countLikes,
    getPostsTitle,
    deletePost
};