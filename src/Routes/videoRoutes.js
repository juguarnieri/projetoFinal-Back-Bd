const express = require("express");
const router = express.Router();
const videoController = require("../controllers/videoController");

router.post("/", videoController.createVideo);
router.get("/", videoController.getAllVideos);
router.get("/category/:category", videoController.getVideosByCategory);
router.get("/:id", videoController.getVideoById);
router.put("/:id", videoController.updateVideo);
router.delete("/:id", videoController.deleteVideo);
router.get("/featured", videoController.getFeaturedVideos);

module.exports = router;
