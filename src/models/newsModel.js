const pool = require("../config/database");

const create = async ({ title, description, text, link, image, category, is_featured, year, decade }) => {
  const result = await pool.query(
    `INSERT INTO news (title, description, text, link, image, category, is_featured, year, decade)
     VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9) RETURNING *`,
    [title, description, text, link, image, category, is_featured, year, decade]
  );
  return result.rows[0];
};

const findAll = async () => {
  const result = await pool.query("SELECT * FROM news ORDER BY created_at DESC");
  return result.rows;
};

const getByTitle = async (title) => {
  const result = await pool.query(
    "SELECT * FROM news WHERE title ILIKE $1 ORDER BY created_at DESC",
    [`%${title}%`]
  );
  return result.rows;
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
  return result.rows;
};

const getByDecade = async (decade) => {
  const result = await pool.query(
    "SELECT * FROM news WHERE decade = $1 ORDER BY created_at DESC",
    [decade]
  );
  return result.rows;
};

const getFeatured = async () => {
  const result = await pool.query(
    "SELECT * FROM news WHERE is_featured = TRUE ORDER BY created_at DESC"
  );
  return result.rows;
};

const update = async (id, { title, description, text, link, image, category, is_featured, year, decade }) => {
  const result = await pool.query(
    `UPDATE news 
     SET title = $1, description = $2, text = $3, link = $4, image = $5, category = $6, is_featured = $7, year = $8, decade = $9
     WHERE id = $10 RETURNING *`,
    [title, description, text, link, image, category, is_featured || false, year, decade, id]
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

module.exports = {
  create,
  findAll,
  getByTitle,
  getByCategory,
  getByYear,
  getByDecade,
  getFeatured,
  update,
  remove,
  findById,
};
