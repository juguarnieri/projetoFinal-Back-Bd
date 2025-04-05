const pool = require("../config/database");

const create = async ({ username, name, profile_picture }) => {
    const result = await pool.query(
        "INSERT INTO users (username, name, profile_picture) VALUES ($1, $2, $3) RETURNING *",
        [username, name, profile_picture]
    );
    return result.rows[0];
};
module.exports = {
    create,
    //findById,
    //findAll,
    //update,
    //follow,
    //unfollow,
    //countFollowers,
    //countFollowing,
    //countLikes,
    //getFollowersList,
    //getFollowingList,
    //isAlreadyFollowing,
};
