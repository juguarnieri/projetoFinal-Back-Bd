const pool = require("../config/database");

const create = async ({ title, description, link, image, category }) => {
    const result = await pool.query(
        `INSERT INTO podcasts (title, description, link, image, category) 
         VALUES ($1, $2, $3, $4, $5) RETURNING *`,
        [title, description, link, image, category]
    );
    return result.rows[0];
};


module.exports = {
    //getAll,
    //getByCategory,
    create,
    //findAll
};