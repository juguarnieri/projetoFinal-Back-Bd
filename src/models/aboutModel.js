const pool = require("../config/database");

const createAboutPage = async ({ main_title, subtitle, description, commitment_title, commitment_text }) => {
  const result = await pool.query(
    `INSERT INTO about_page (main_title, subtitle, description, commitment_title, commitment_text)
     VALUES ($1, $2, $3, $4, $5) RETURNING *`,
    [main_title, subtitle, description, commitment_title, commitment_text]
  );
  return result.rows[0];
};

const findAboutPage = async () => {
  const result = await pool.query("SELECT * FROM about_page LIMIT 1");
  return result.rows[0];
};

const updateAboutPage = async (id, data) => {
    const { main_title, subtitle, description, commitment_title, commitment_text } = data;
    const result = await pool.query(
      `UPDATE about_page SET 
        main_title = $1, 
        subtitle = $2, 
        description = $3, 
        commitment_title = $4, 
        commitment_text = $5,
        updated_at = NOW()
       WHERE id = $6 RETURNING *`,
      [main_title, subtitle, description, commitment_title, commitment_text, id]
    );
    return result.rows[0];
  };
  
const getTeamMembers = async () => {
  const result = await pool.query("SELECT * FROM team_members ORDER BY created_at ASC");
  return result.rows;
};

const addTeamMember = async ({ name, role, photo_url, about_page_id }) => {
  const result = await pool.query(
    `INSERT INTO team_members (name, role, photo_url, about_page_id)
     VALUES ($1, $2, $3, $4) RETURNING *`,
    [name, role, photo_url, about_page_id]
  );
  return result.rows[0];
};

const updateTeamMember = async (id, { name, role, photo_url }) => {
    const result = await pool.query(
      `UPDATE team_members SET 
        name = $1, 
        role = $2, 
        photo_url = $3,
        updated_at = NOW()
       WHERE id = $4 RETURNING *`,
      [name, role, photo_url, id]
    );
    return result.rows[0];
  };
  
const deleteTeamMember = async (id) => {
  const result = await pool.query("DELETE FROM team_members WHERE id = $1 RETURNING *", [id]);
  return result.rows[0];
};
const getTeamMemberById = async (id) => {
    const result = await pool.query("SELECT * FROM team_members WHERE id = $1", [id]);
    return result.rows[0];
  };
  

module.exports = {
  createAboutPage,
  findAboutPage,
  updateAboutPage,
  getTeamMembers,
  addTeamMember,
  updateTeamMember,
  deleteTeamMember,
  getTeamMemberById
};
