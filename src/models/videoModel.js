const pool = require("../config/database");

const create = async ({ title, description, link, image, category }) => {
    const result = await pool.query(
        `INSERT INTO videos (title, description, link, image, category) 
         VALUES ($1, $2, $3, $4, $5) RETURNING *`,
        [title, description, link, image, category]
    );
    return result.rows[0];
};
const getAll = async () => {
    const result = await pool.query("SELECT * FROM videos ORDER BY created_at DESC");
    return result.rows;
};
const findAll = async () => {
    const result = await pool.query("SELECT * FROM videos ORDER BY created_at DESC");
    return result.rows;
};
module.exports = {
    getAll,
    //getByCategory,
    create,
    findAll
};