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
const findAll = async () => {
    const result = await pool.query("SELECT * FROM users");
    return result.rows;
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
const follow = async (userId, targetId) => {
    const alreadyFollowing = await isAlreadyFollowing(userId, targetId);
    if (alreadyFollowing) {
        throw new Error("Usuário já está seguindo este perfil.");
    }

    await pool.query(
        "INSERT INTO followers (follower_id, following_id) VALUES ($1, $2)",
        [userId, targetId]
    );
};
const unfollow = async (userId, targetId) => {
    await pool.query(
        "DELETE FROM followers WHERE follower_id = $1 AND following_id = $2", 
        [userId, targetId]
    );
};
const isAlreadyFollowing = async (userId, targetId) => {
    const result = await pool.query(
        "SELECT 1 FROM followers WHERE follower_id = $1 AND following_id = $2",
        [userId, targetId]
    );
    return result.rowCount > 0;
};

const update = async (id, { username, name, profile_picture }) => {
    const result = await pool.query(
        `UPDATE users 
         SET username = $1, name = $2, profile_picture = $3
         WHERE id = $4 
         RETURNING *`,
        [username, name, profile_picture, id]
    );
    return result.rows[0];
};
const getFollowersList = async (userId) => {
    const result = await pool.query(
        `SELECT u.id, u.username, u.name, u.profile_picture
         FROM followers f
         JOIN users u ON u.id = f.follower_id
         WHERE f.following_id = $1`,
        [userId]
    );
    return result.rows;
};

const getFollowingList = async (userId) => {
    const result = await pool.query(
        `SELECT u.id, u.username, u.name, u.profile_picture
         FROM followers f
         JOIN users u ON u.id = f.following_id
         WHERE f.follower_id = $1`,
        [userId]
    );
    return result.rows;
};
const deleteUser = async (req, res) => {
    const { id } = req.params;

    try {
        const deletedUser = await User.remove(id);
        if (!deletedUser) return res.status(404).json({ error: "Usuário não encontrado" });

        res.json({ message: "Usuário deletado com sucesso", user: deletedUser });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: "Erro ao deletar usuário" });
    }
};

module.exports = {
    create,
    findById,
    findAll,
    update,
    follow,
    unfollow,
    countFollowers,
    countFollowing,
    countLikes,
    getFollowersList,
    getFollowingList,
    isAlreadyFollowing,
    deleteUser
};
