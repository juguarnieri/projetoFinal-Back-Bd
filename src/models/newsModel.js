const pool = require("../config/database");

const create = async ({ title, description, link, image, category, is_featured, year, decade }) => {
    const result = await pool.query(
        `INSERT INTO news (title, description, link, image, category, is_featured, year, decade)
         VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
         RETURNING *`,
        [title, description, link, image, category, is_featured, year, decade]
    );
    return result.rows[0];
};


const findAll = async () => {
    const result = await pool.query("SELECT * FROM news ORDER BY created_at DESC");
    return result.rows;
};

const getByTitle = async (title) => {
    if (!title) {
        const result = await pool.query("SELECT * FROM news ORDER BY created_at DESC");
        return result.rows;
    } else {
        const result = await pool.query(
            "SELECT * FROM news WHERE title ILIKE $1 ORDER BY created_at DESC",
            [`%${title}%`]
        );
        return result.rows;
    }
};



const getByCategory = async (category) => {
    const result = await pool.query(
        "SELECT * FROM news WHERE category ILIKE $1 ORDER BY created_at DESC",
        [`%${category}%`]
    );
    return result.rows;
};

const getByYear = async (year) => {
    const result = await pool.query(
        "SELECT * FROM news WHERE year = $1 ORDER BY created_at DESC",
        [year]
    );
    console.log("Notícias encontradas pelo ano:", result.rows);
    return result.rows;
};

const getFeatured = async () => {
    const result = await pool.query("SELECT * FROM news WHERE is_featured = TRUE ORDER BY created_at DESC");
    return result.rows;
};

const update = async (id, { title, description, link, image, category, is_featured }) => {
    const result = await pool.query(
        `UPDATE news 
         SET title = $1, description = $2, link = $3, image = $4, category = $5, is_featured = $6
         WHERE id = $7 RETURNING *`,
        [title, description, link, image, category, is_featured || false, id]
    );
    return result.rows[0];
};

const remove = async (id) => {
    await pool.query("DELETE FROM news WHERE id = $1", [id]);
};

const findById = async (id) => {
    const result = await pool.query("SELECT * FROM news WHERE id = $1", [id]);
    return result.rows[0];
};
const getByDecade = async (decade) => {
    const result = await pool.query(
      "SELECT * FROM news WHERE decade = $1 ORDER BY created_at DESC",
      [decade]
    );
    return result.rows;
  };
  
module.exports = {
    create,
    findAll,
    getByCategory,
    getFeatured,
    update,
    remove,
    findById,
    getByDecade,
    getByTitle,
    getByYear
};
