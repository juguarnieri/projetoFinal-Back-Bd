const pool = require("../config/database");

const create = async ({ title, description, link, image, category }) => {
    const result = await pool.query(
        `INSERT INTO podcasts (title, description, link, image, category)
         VALUES ($1, $2, $3, $4, $5) RETURNING *`,
        [title, description, link, image, category]
    );
    return result.rows[0];
};

const findAll = async () => {
    const result = await pool.query("SELECT * FROM podcasts ORDER BY created_at DESC");
    return result.rows;
};

const getByCategory = async (category) => {
    const result = await pool.query(
        "SELECT * FROM podcasts WHERE category ILIKE $1 ORDER BY created_at DESC",
        [category]
    );
    return result.rows;
};

const update = async (id, { title, description, link, image, category }) => {
    const result = await pool.query(
        `UPDATE podcasts SET title = $1, description = $2, link = $3, image = $4, category = $5
         WHERE id = $6 RETURNING *`,
        [title, description, link, image, category, id]
    );
    return result.rows[0];
};

const remove = async (id) => {
    await pool.query("DELETE FROM podcasts WHERE id = $1", [id]);
};

const findById = async (id) => {
    const result = await pool.query("SELECT * FROM podcasts WHERE id = $1", [id]);
    return result.rows[0];
};

module.exports = {
    create,
    findAll,
    getByCategory,
    update,
    remove,
    findById
};
