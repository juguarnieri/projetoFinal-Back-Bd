const PDFDocument = require("pdfkit");
const User = require("../models/userModel");

const exportUsersPDF = async (req, res) => {
    try {
        const users = await User.findAll();

        if (!users || users.length === 0) {
            return res.status(404).json({ error: "Nenhum usuário encontrado para exportação" });
        }

        res.setHeader("Content-Type", "application/pdf");
        res.setHeader("Content-Disposition", "inline; filename=users.pdf");

        const doc = new PDFDocument();
        doc.pipe(res);

        doc.fontSize(20).text("Relatório de Usuários", { align: "center" });
        doc.moveDown();

        doc.fontSize(12).text("ID | Nome | Username | Email", { underline: true });
        doc.moveDown(0.5);

        users.forEach(user => {
            doc.text(`${user.id} | ${user.name || '-'} | ${user.username || '-'} | ${user.email || '-'}`);
        });

        doc.end();
    } catch (err) {
        console.error("Erro ao gerar PDF de usuários:", err);
        res.status(500).json({ error: "Erro ao gerar PDF de usuários", details: err.message });
    }
};

module.exports = {
    exportUsersPDF
};
