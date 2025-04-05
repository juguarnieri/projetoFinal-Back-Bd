const pool = require("../config/database");

const create = async ({ user_id, title, caption, media_url }) => {
    const result = await pool.query(
        "INSERT INTO posts (user_id, title, caption, media_url) VALUES ($1, $2, $3, $4) RETURNING *",
        [user_id, title, caption, media_url]
    );
    return result.rows[0];
};

module.exports = {
    create,
    //findByUser,
    //like,
    //unlike,
    //countLikes,
};
