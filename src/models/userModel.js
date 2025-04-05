const pool = require("../config/database");

const create = async ({ username, name, profile_picture }) => {
    const result = await pool.query(
        "INSERT INTO users (username, name, profile_picture) VALUES ($1, $2, $3) RETURNING *",
        [username, name, profile_picture]
    );
    return result.rows[0];
};
const findById = async (id) => {
    const result = await pool.query("SELECT * FROM users WHERE id = $1", [id]);
    return result.rows[0];
};
const countFollowers = async (userId) => {
    const result = await pool.query(
        "SELECT COUNT(*) FROM followers WHERE following_id = $1",
        [userId]
    );
    return parseInt(result.rows[0].count);
};

const countFollowing = async (userId) => {
    const result = await pool.query(
        "SELECT COUNT(*) FROM followers WHERE follower_id = $1", 
        [userId]
    );
    return parseInt(result.rows[0].count);
};
const countLikes = async (userId) => {
    const result = await pool.query(
        `SELECT COUNT(*) 
         FROM likes 
         WHERE post_id IN (
        SELECT id FROM posts WHERE user_id = $1
         )`,
        [userId]
    );
    return parseInt(result.rows[0].count);
};

module.exports = {
    create,
    findById,
    //findAll,
    //update,
    //follow,
    //unfollow,
    countFollowers,
    countFollowing,
    countLikes,
    //getFollowersList,
    //getFollowingList,
    //isAlreadyFollowing,
};
