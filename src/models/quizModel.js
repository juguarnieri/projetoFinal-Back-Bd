const pool = require("../config/database");
const getAllQuestions = async () => {
    const questionsResult = await pool.query("SELECT * FROM questions ORDER BY id ASC");
    const questions = questionsResult.rows;

    for (const question of questions) {
        const alternativesResult = await pool.query(
            "SELECT id, alternative_text FROM alternatives WHERE question_id = $1 ORDER BY id ASC",
            [question.id]
        );
        question.alternatives = alternativesResult.rows;
    }

    return questions;
};

const getCorrectAlternatives = async () => {
    const result = await pool.query(
        "SELECT question_id, id FROM alternatives WHERE is_correct = TRUE"
    );
    return result.rows;
};

module.exports = {
    getAllQuestions,
    getCorrectAlternatives
};