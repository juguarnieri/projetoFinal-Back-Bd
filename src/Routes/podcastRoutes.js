const express = require("express");
const router = express.Router();
const podcastController = require("../controllers/podcastController");

router.post("/", podcastController.createPodcast);
router.get("/category/:category", podcastController.getPodcastsByCategory);
router.get("/featured", podcastController.getFeaturedPodcasts);
router.get("/", podcastController.getAllPodcasts);
router.put("/:id", podcastController.updatePodcast);
router.delete("/:id", podcastController.deletePodcast);
router.get("/:id", podcastController.getPodcastById); 

module.exports = router;
