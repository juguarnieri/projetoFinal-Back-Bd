const pool = require("../config/database");

const createComment = async ({ user_id, post_id, content }) => {
    const result = await pool.query(
        "INSERT INTO comments (user_id, post_id, content) VALUES ($1, $2, $3) RETURNING *",
        [user_id, post_id, content]
    );
    return result.rows[0];
};
const getCommentsByPost = async (post_id) => {
    const result = await pool.query(
        `SELECT comments.content, comments.created_at, users.username
         FROM comments
         JOIN users ON comments.user_id = users.id
         WHERE comments.post_id = $1
         ORDER BY comments.created_at DESC`,
        [post_id]
    );
    return result.rows;
};
const getCommentById = async (id) => {
    const result = await pool.query(
        `SELECT c.id, c.content, c.created_at, u.username
         FROM comments c
         JOIN users u ON c.user_id = u.id
         WHERE c.id = $1`,
        [id]
    );
    return result.rows[0];
};

const updateComment = async (id, content) => {
    const result = await pool.query(
        "UPDATE comments SET content = $1 WHERE id = $2 RETURNING *",
        [content, id]
    );
    return result.rows[0];
};
const deleteComment = async (id) => {
    const result = await pool.query(
        "DELETE FROM comments WHERE id = $1 RETURNING *",
        [id]
    );
    return result.rows[0];
};
const countCommentsByPost = async (post_id) => {
    const result = await pool.query(
        "SELECT COUNT(*) FROM comments WHERE post_id = $1",
        [post_id]
    );
    return parseInt(result.rows[0].count);
};


module.exports = {
    createComment,
    getCommentsByPost,
    updateComment,
    deleteComment,
    getCommentById,
    countCommentsByPost,
    countCommentsByPost
};
