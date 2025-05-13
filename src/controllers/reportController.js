const PDFDocument = require("pdfkit");
const User = require("../models/userModel");
const Post = require("../models/postModel");
const Comment = require("../models/commentModel");
const News = require("../models/newsModel");
const Podcast = require("../models/podcastModel");
const Video = require("../models/videoModel");
const About = require("../models/aboutModel");

// Função para gerar o relatório de usuários em PDF
const exportUsersPDF = async (req, res) => {
    try {
        const users = await User.findAll();
        if (!users || users.length === 0) {
            return res.status(404).json({ error: "Nenhum usuário encontrado para exportação" });
        }

        const doc = new PDFDocument();
        res.setHeader("Content-Type", "application/pdf");
        res.setHeader("Content-Disposition", "attachment; filename=users.pdf");
        doc.pipe(res);

        doc.fontSize(20).text("Relatório de Usuários", { align: "center" }).moveDown();
        doc.fontSize(12).text("ID | Nome | Username | Email", { underline: true }).moveDown(0.5);

        users.forEach(user => {
            doc.text(`${user.id} | ${user.name || '-'} | ${user.username || '-'} | ${user.email || '-'}`);
        });

        doc.end();
    } catch (err) {
        console.error("Erro ao gerar PDF de usuários:", err);
        res.status(500).json({ error: "Erro ao gerar PDF de usuários", details: err.message });
    }
};

// Função para gerar o relatório de posts em PDF
const exportPostsPDF = async (req, res) => {
    try {
        const posts = await Post.findAll();
        if (!posts || posts.length === 0) {
            return res.status(404).json({ error: "Nenhum post encontrado para exportação" });
        }

        const doc = new PDFDocument();
        res.setHeader("Content-Type", "application/pdf");
        res.setHeader("Content-Disposition", "attachment; filename=posts.pdf");
        doc.pipe(res);

        doc.fontSize(20).text("Relatório de Posts", { align: "center" }).moveDown();
        doc.fontSize(12).text("ID | Usuário | Título | Curtidas", { underline: true }).moveDown(0.5);

        posts.forEach(post => {
            doc.text(`${post.id} | ${post.user_name || post.username || '-'} | ${post.title || '-'} | ${post.like_count || 0}`);
        });

        doc.end();
    } catch (err) {
        console.error("Erro ao gerar PDF de posts:", err);
        res.status(500).json({ error: "Erro ao gerar PDF de posts", details: err.message });
    }
};

// Função para gerar o relatório de comentários em PDF
const exportCommentsPDF = async (req, res) => {
    try {
        const comments = await Comment.getAllComments();
        if (!comments || comments.length === 0) {
            return res.status(404).json({ error: "Nenhum comentário encontrado para exportação" });
        }

        const doc = new PDFDocument();
        res.setHeader("Content-Type", "application/pdf");
        res.setHeader("Content-Disposition", "attachment; filename=comentarios.pdf");
        doc.pipe(res);

        doc.fontSize(20).text("Relatório de Comentários", { align: "center" }).moveDown();
        doc.fontSize(12).text("ID | Usuário | Post | Conteúdo", { underline: true }).moveDown(0.5);

        comments.forEach(comment => {
            const line = `${comment.id} | ${comment.user_name || comment.username || '-'} | ${comment.post_title || '-'} | ${comment.content.slice(0, 50)}${comment.content.length > 50 ? "..." : ""}`;
            doc.text(line);
        });

        doc.end();
    } catch (err) {
        console.error("Erro ao gerar PDF de comentários:", err);
        res.status(500).json({ error: "Erro ao gerar PDF de comentários", details: err.message });
    }
};

// Função para gerar o relatório de notícias em PDF
const exportNewsPDF = async (req, res) => {
    try {
        const newsList = await News.findAll();
        if (!newsList || newsList.length === 0) {
            return res.status(404).json({ error: "Nenhuma notícia encontrada para exportação" });
        }

        const doc = new PDFDocument();
        res.setHeader("Content-Type", "application/pdf");
        res.setHeader("Content-Disposition", "attachment; filename=noticias.pdf");
        doc.pipe(res);

        doc.fontSize(20).text("Relatório de Notícias", { align: "center" }).moveDown();
        doc.fontSize(12).text("ID | Título | Ano | Década | Categoria", { underline: true }).moveDown(0.5);

        newsList.forEach(news => {
            const line = `${news.id} | ${news.title.slice(0, 30)}${news.title.length > 30 ? "..." : ""} | ${news.year} | ${news.decade} | ${news.category}`;
            doc.text(line);
        });

        doc.end();
    } catch (err) {
        console.error("Erro ao gerar PDF de notícias:", err);
        res.status(500).json({ error: "Erro ao gerar PDF de notícias", details: err.message });
    }
};

// Função para gerar o relatório de podcasts em PDF
const exportPodcastsPDF = async (req, res) => {
    try {
        const podcasts = await Podcast.findAll();
        if (!podcasts || podcasts.length === 0) {
            return res.status(404).json({ error: "Nenhum podcast encontrado para exportação" });
        }

        const doc = new PDFDocument();
        res.setHeader("Content-Type", "application/pdf");
        res.setHeader("Content-Disposition", "attachment; filename=podcasts.pdf");
        doc.pipe(res);

        doc.fontSize(20).text("Relatório de Podcasts", { align: "center" }).moveDown();
        doc.fontSize(12).text("ID | Título | Categoria", { underline: true }).moveDown(0.5);

        podcasts.forEach(podcast => {
            const line = `${podcast.id} | ${podcast.title.slice(0, 30)}${podcast.title.length > 30 ? "..." : ""} | ${podcast.category}`;
            doc.text(line);
        });

        doc.end();
    } catch (err) {
        console.error("Erro ao gerar PDF de podcasts:", err);
        res.status(500).json({ error: "Erro ao gerar PDF de podcasts", details: err.message });
    }
};

// Função para gerar o relatório de vídeos em PDF
const exportVideosPDF = async (req, res) => {
    try {
        const videos = await Video.findAll();
        if (!videos || videos.length === 0) {
            return res.status(404).json({ error: "Nenhum vídeo encontrado para exportação" });
        }

        const doc = new PDFDocument();
        res.setHeader("Content-Type", "application/pdf");
        res.setHeader("Content-Disposition", "attachment; filename=videos.pdf");
        doc.pipe(res);

        doc.fontSize(20).text("Relatório de Vídeos", { align: "center" }).moveDown();
        doc.fontSize(12).text("ID | Título | Categoria", { underline: true }).moveDown(0.5);

        videos.forEach(video => {
            const line = `${video.id} | ${video.title.slice(0, 30)}${video.title.length > 30 ? "..." : ""} | ${video.category}`;
            doc.text(line);
        });

        doc.end();
    } catch (err) {
        console.error("Erro ao gerar PDF de vídeos:", err);
        res.status(500).json({ error: "Erro ao gerar PDF de vídeos", details: err.message });
    }
};

// Função para gerar o relatório da página "Sobre Nós" em PDF
const exportAboutPDF = async (req, res) => {
    try {
        const page = await About.findAboutPage();
        const team = await About.getTeamMembers();

        if (!page) {
            return res.status(404).json({ error: "Página 'Sobre Nós' não encontrada para exportação." });
        }

        const doc = new PDFDocument({ margin: 50 });
        res.setHeader("Content-Type", "application/pdf");
        res.setHeader("Content-Disposition", "attachment; filename=sobre-nos.pdf");
        doc.pipe(res);

        doc.fontSize(20).text("Página Sobre Nós", { align: "center" }).moveDown();
        doc.fontSize(14).text(`Título Principal: ${page.main_title}`);
        doc.text(`Subtítulo: ${page.subtitle}`);
        doc.text(`Descrição: ${page.description}`);
        doc.text(`Compromisso: ${page.commitment_title}`);
        doc.text(`Texto do Compromisso: ${page.commitment_text}`).moveDown();

        doc.fontSize(16).text("Equipe", { underline: true }).moveDown(0.5);

        if (team.length === 0) {
            doc.fontSize(12).text("Nenhum membro da equipe cadastrado.");
        } else {
            team.forEach((member, index) => {
                doc.fontSize(12).text(`${index + 1}. ${member.name} - ${member.role}`);
            });
        }

        doc.end();
    } catch (err) {
        console.error("Erro ao gerar PDF da página Sobre:", err);
        res.status(500).json({ error: "Erro ao gerar PDF da página Sobre", details: err.message });
    }
};

module.exports = {
    exportUsersPDF,
    exportPostsPDF,
    exportCommentsPDF,
    exportNewsPDF,
    exportPodcastsPDF,
    exportVideosPDF,
    exportAboutPDF
};
