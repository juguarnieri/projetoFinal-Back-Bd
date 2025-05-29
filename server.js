require("dotenv").config();
const cors = require("cors");
const express = require("express");
const userRoutes = require("./src/routes/userRoutes");
const postRoutes = require("./src/routes/postRoutes");
const commentRoutes = require('./src/routes/commentRoutes');
const newsRoutes = require("./src/routes/newsRoutes");  
const podcastRoutes = require("./src/routes/podcastRoutes"); 
const path = require("path");
const videoRoutes = require("./src/routes/videoRoutes");   
const aboutRoutes = require("./src/routes/aboutRoutes");
const reportRoutes = require("./src/routes/reportRoutes");
const quizRoutes = require("./src/routes/quizRoutes");
const setupSwagger = require("./src/config/swagger");

const app = express();
app.use(cors());
app.use("/uploads", express.static(path.join(__dirname, "uploads")));
app.use(express.json());
setupSwagger(app);

app.use("/api/users", userRoutes);
app.use("/api/posts", postRoutes);
app.use("/api/comments", commentRoutes);
app.use("/api/news", newsRoutes);   
app.use("/api/podcasts", podcastRoutes);
app.use("/api/videos", videoRoutes); 
app.use("/api/about", aboutRoutes);
app.use("/api/reports", reportRoutes);
app.use("/api/quiz", quizRoutes);


app.get("/", (req, res) => {
    res.send("🚀 API funcionando com Users, Posts, Comments, News, Videos e Podcasts!");
});

const PORT = process.env.PORT || 4000;
app.listen(PORT, () => {
    console.log(`🚀 Servidor rodando em http://localhost:${PORT}`);
});
