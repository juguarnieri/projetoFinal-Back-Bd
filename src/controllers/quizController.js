const Quiz = require("../models/quizModel");

const getAllQuestions = async (req, res) => {
    try {
        const questions = await Quiz.getAllQuestions();
        res.json(questions);
    } catch (err) {
        console.error("Erro ao buscar questões:", err);
        res.status(500).json({ error: "Erro ao buscar questões" });
    }
};

const submitQuiz = async (req, res) => {
    try {
        const { answers } = req.body; 
        if (!Array.isArray(answers)) {
            return res.status(400).json({ error: "Formato de respostas inválido" });
        }

        const correct = await Quiz.getCorrectAlternatives();
        let score = 0;
        const correction = answers.map(ans => {
            const found = correct.find(c => c.question_id === ans.question_id);
            const isCorrect = found && found.id === ans.alternative_id;
            if (isCorrect) score++;
            return {
                question_id: ans.question_id,
                your_answer: ans.alternative_id,
                correct_alternative_id: found ? found.id : null,
                is_correct: isCorrect
            };
        });

        res.json({ total: correct.length, correct: score, correction });
    } catch (err) {
        console.error("Erro ao corrigir quiz:", err);
        res.status(500).json({ error: "Erro ao corrigir quiz" });
    }
};

module.exports = {
    getAllQuestions,
    submitQuiz
};