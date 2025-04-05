const express = require("express");
const router = express.Router();

const videoController = require("../controllers/videoController");

router.get("/", videoController.getAllVideos);
router.get("/category/:category", videoController.getByCategory);
router.post("/", videoController.createVideo);

module.exports = router;
