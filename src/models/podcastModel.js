const pool = require("../config/database");

const create = async ({ title, description, link, image, category, is_featured }) => {
    const result = await pool.query(
        `INSERT INTO podcasts (title, description, link, image, category, is_featured)
         VALUES ($1, $2, $3, $4, $5, $6) RETURNING *`,
        [title, description, link, image, category, is_featured || false]
    );
    return result.rows[0];
};

const findAll = async (titulo) => {
    let query = "SELECT * FROM podcasts";
    const params = [];

    if (titulo) {
        query += " WHERE title ILIKE $1";
        params.push(`%${titulo}%`);
    }

    query += " ORDER BY title ASC";
    const result = await pool.query(query, params);

    return result.rows;
};

const getByCategory = async (category) => {
    const result = await pool.query(
        "SELECT * FROM podcasts WHERE category ILIKE $1 ORDER BY created_at DESC",
        [`%${category}%`]
    );
    return result.rows;
};

const getFeatured = async () => {
    const result = await pool.query(
        "SELECT * FROM podcasts WHERE is_featured = TRUE ORDER BY created_at DESC"
    );
    return result.rows;
};

const findById = async (id) => {
    const result = await pool.query(
        "SELECT * FROM podcasts WHERE id = $1",
        [id]
    );
    return result.rows[0];
};

const update = async (id, { title, description, link, image, category, is_featured }) => {
    const result = await pool.query(
        `UPDATE podcasts 
         SET title = $1, description = $2, link = $3, image = $4, category = $5, is_featured = $6
         WHERE id = $7 RETURNING *`,
        [title, description, link, image, category, is_featured || false, id]
    );
    return result.rows[0];
};

const remove = async (id) => {
    const result = await pool.query(
        "DELETE FROM podcasts WHERE id = $1 RETURNING *",
        [id]
    );
    return result.rows[0];
};

module.exports = {
    create,
    findAll,
    getByCategory,
    getFeatured,
    findById,
    update,
    remove
};
