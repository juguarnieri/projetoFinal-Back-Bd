const express = require("express");
const router = express.Router();

const newsController = require("../controllers/newsController");

//router.get("/", newsController.getAllNews);
//router.get("/category/:category", newsController.getByCategory);
router.post("/", newsController.createNews);

module.exports = router;
