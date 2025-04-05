const pool = require("../config/database");

const createComment = async ({ user_id, post_id, content }) => {
    const result = await pool.query(
        "INSERT INTO comments (user_id, post_id, content) VALUES ($1, $2, $3) RETURNING *",
        [user_id, post_id, content]
    );
    return result.rows[0];
};

module.exports = {
    createComment,
    //getCommentsByPost,
    //updateComment,
    //deleteComment,
    //getCommentById
};
