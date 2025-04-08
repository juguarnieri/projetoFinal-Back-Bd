const express = require("express");
const router = express.Router();
const newsController = require("../controllers/newsController");

router.get("/featured", newsController.getFeaturedNews);
router.get("/category/:category", newsController.getNewsByCategory);
router.get("/decade/:decade", newsController.getNewsByDecade);
router.get("/", newsController.getAllNews);

router.post("/", newsController.createNews);
router.put("/:id", newsController.updateNews);
router.delete("/:id", newsController.deleteNews);
router.get("/:id", newsController.getNewsById); 

module.exports = router;
