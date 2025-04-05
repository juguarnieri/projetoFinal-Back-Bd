require("dotenv").config();
const express = require("express");
const userRoutes = require("./src/routes/userRoutes");
const postRoutes = require("./src/routes/postRoutes");

const app = express();
app.use(cors());
app.use(express.json());

app.use("/api/users", userRoutes);
app.use("/api/posts", postRoutes);

app.get("/", (req, res) => {
    res.send("🚀 API funcionando com Users, Posts, Comments, News, Videos e Podcasts!");
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`🚀 Servidor rodando em http://localhost:${PORT}`);
});
