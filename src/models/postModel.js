const pool = require("../config/database");

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
const findAll = async () => {
    const result = await pool.query(`
        SELECT 
            posts.*, 
            users.name AS user_name, 
            users.username, 
            users.profile_picture,
            COUNT(likes.post_id) AS like_count
        FROM posts
        JOIN users ON posts.user_id = users.id
        LEFT JOIN likes ON posts.id = likes.post_id
        GROUP BY posts.id, users.id
        ORDER BY posts.created_at DESC
    `);
    return result.rows;
};

const deletePost = async (postId) => {
    const result = await pool.query("DELETE FROM posts WHERE id = $1", [postId]);
    return result.rowCount > 0; 
};



module.exports = {
    create,
    findByUser,
    like,
    unlike,
    countLikes,
    findAll,
    deletePost
};
