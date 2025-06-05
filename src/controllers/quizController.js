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

        const allQuestions = await Quiz.getAllQuestions();
        const correct = await Quiz.getCorrectAlternatives();
        let score = 0;

        const correction = answers.map(ans => {
            const question = allQuestions.find(q => q.id === ans.question_id);
            const found = correct.find(c => c.question_id === ans.question_id);
            const yourAlt = question?.alternatives.find(a => a.id === ans.alternative_id);
            const correctAlt = question?.alternatives.find(a => a.id === (found ? found.id : null));
            const yourIndex = question?.alternatives.findIndex(a => a.id === ans.alternative_id);
            const correctIndex = question?.alternatives.findIndex(a => a.id === (found ? found.id : null));
            const isCorrect = found && found.id === ans.alternative_id;
            if (isCorrect) score++;
            return {
                question_id: ans.question_id,
                question_text: question?.question_text,
                your_answer: ans.alternative_id,
                your_answer_text: yourAlt?.alternative_text,
                your_answer_letter: yourIndex !== undefined && yourIndex !== -1 ? String.fromCharCode(65 + yourIndex) : null,
                correct_alternative_id: found ? found.id : null,
                correct_alternative_text: correctAlt?.alternative_text,
                correct_alternative_letter: correctIndex !== undefined && correctIndex !== -1 ? String.fromCharCode(65 + correctIndex) : null,
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