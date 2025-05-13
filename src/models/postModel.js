const pool = require("../config/database");

const getAllPosts = async (minLikes = 0) => {
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
const getPostsTitle = async (title) =>{
    if (!title) {
        const result = await pool.query(`
            SELECT * FROM posts ORDER BY created_at DESC`);
        return result.rows;
    } else {
        const result = await pool.query(`
            SELECT * FROM posts WHERE title ILIKE $1 ORDER BY created_at DESC`,
            [`%${title}%`]
        );
        return result.rows;
    }
};
const filterByStartDate = async (startDate) => {
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
        WHERE posts.created_at >= $1
        GROUP BY posts.id, posts.user_id, posts.title, posts.caption, posts.media_url, posts.created_at
        ORDER BY posts.created_at DESC
    `, [startDate]);
    return result.rows;
};

const deletePost = async (postId) => {
    const result = await pool.query("DELETE FROM posts WHERE id = $1", [postId]);
    return result.rowCount > 0; 
};

const getPostById = async (id) => {
    const result = await pool.query("SELECT * FROM posts WHERE id = $1", [id]);
    return result.rows[0]; // Retorna o post se existir, ou undefined se não existir
};
const findAll = async () => {
    const result = await pool.query(
        `SELECT posts.id, posts.title, users.username AS user_name, COUNT(likes.id) AS like_count
         FROM posts
         LEFT JOIN users ON posts.user_id = users.id
         LEFT JOIN likes ON posts.id = likes.post_id
         GROUP BY posts.id, users.username
         ORDER BY posts.created_at DESC`
    );
    return result.rows;
};


module.exports = {
    getAllPosts,
    create,
    findByUser,
    like,
    unlike,
    countLikes,
    getPostsTitle,
    filterByStartDate,
    getPostById,
    deletePost,
    findAll
};