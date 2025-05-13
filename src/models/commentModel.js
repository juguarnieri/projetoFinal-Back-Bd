const pool = require("../config/database");

const createComment = async ({ user_id, post_id, content }) => {
    const result = await pool.query(
        `INSERT INTO comments (user_id, post_id, content) 
         VALUES ($1, $2, $3) 
         RETURNING id`,
        [user_id, post_id, content]
    );

    const commentId = result.rows[0].id;

    const fullComment = await pool.query(`
        SELECT 
            comments.id,
            comments.content,
            comments.created_at,
            users.id AS user_id,
            users.username,
            users.name AS user_name,
            users.profile_picture,
            posts.id AS post_id,
            posts.title AS post_title,
            postAuthor.name AS post_author_name
        FROM comments
        JOIN users ON comments.user_id = users.id
        JOIN posts ON comments.post_id = posts.id
        JOIN users AS postAuthor ON posts.user_id = postAuthor.id
        WHERE comments.id = $1
    `, [commentId]);

    return fullComment.rows[0];
};

const getCommentsByPost = async (post_id) => {
    const result = await pool.query(
        `SELECT 
            comments.id,
            comments.content,
            comments.created_at,
            users.id AS user_id,
            users.username,
            users.name AS user_name,
            users.profile_picture
         FROM comments
         JOIN users ON comments.user_id = users.id
         WHERE comments.post_id = $1
         ORDER BY comments.created_at ASC`,
        [post_id]
    );
    return result.rows;
};

const getCommentById = async (id) => {
    const result = await pool.query(
        `SELECT 
            comments.id,
            comments.content,
            comments.created_at,
            users.id AS user_id,
            users.username,
            users.name AS user_name,
            users.profile_picture
         FROM comments
         JOIN users ON comments.user_id = users.id
         WHERE comments.id = $1`,
        [id]
    );
    return result.rows[0];
};

const updateComment = async (id, content, userId) => {
    const result = await pool.query(
        `UPDATE comments
         SET content = $1
         WHERE id = $2 AND user_id = $3
         RETURNING id, content, created_at`,
        [content, id, userId]
    );

    if (result.rowCount === 0) {
        return null; 
    }

    const updatedComment = await pool.query(
        `SELECT 
            comments.id AS comment_id,
            comments.content AS comment_content,
            comments.created_at AS comment_created_at,
            posts.id AS post_id,
            posts.title AS post_title,
            users.id AS user_id,
            users.username AS user_username,
            users.name AS user_name
         FROM comments
         JOIN posts ON comments.post_id = posts.id
         JOIN users ON comments.user_id = users.id
         WHERE comments.id = $1`,
        [id]
    );

    return updatedComment.rows[0];
};
const deleteComment = async (id) => {
    const result = await pool.query(
        `DELETE FROM comments 
         WHERE id = $1 
         RETURNING *`,
        [id]
    );
    return result.rows[0];
};

const countCommentsByPost = async (post_id) => {
    const result = await pool.query(
        `SELECT COUNT(*) 
         FROM comments 
         WHERE post_id = $1`,
        [post_id]
    );
    return parseInt(result.rows[0].count);
};
const findAllComments = async () => {
    const result = await pool.query(`
        SELECT 
            comments.id,
            comments.content,
            comments.created_at,
            users.id AS user_id,
            users.username,
            users.name,
            users.profile_picture
        FROM comments
        JOIN users ON comments.user_id = users.id
        ORDER BY comments.created_at DESC
    `);
    return result.rows;
};
const getAllComments = async () => {
    const result = await pool.query(`
        SELECT 
            comments.id,
            comments.content,
            comments.created_at,
            users.id AS user_id,
            users.username,
            users.name AS user_name,
            users.profile_picture,
            posts.id AS post_id,
            posts.title AS post_title
        FROM comments
        JOIN users ON comments.user_id = users.id
        JOIN posts ON comments.post_id = posts.id
        ORDER BY comments.created_at ASC
    `);
    return result.rows;
};



module.exports = {
    createComment,
    getCommentsByPost,
    getCommentById,
    updateComment,
    deleteComment,
    findAllComments,
    countCommentsByPost,
    getAllComments

};

