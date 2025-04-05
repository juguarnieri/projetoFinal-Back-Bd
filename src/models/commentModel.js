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

module.exports = {
    createComment,
    getCommentsByPost,
    //updateComment,
    //deleteComment,
    //getCommentById
};
