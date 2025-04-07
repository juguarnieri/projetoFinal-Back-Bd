const express = require("express");
const router = express.Router();
const podcastController = require("../controllers/podcastController");


router.post("/", podcastController.createPodcast);
router.get("/", podcastController.getAllPodcasts);
router.get("/categoria/:category", podcastController.getPodcastsByCategory);
router.put("/:id", podcastController.updatePodcast);
router.delete("/:id", podcastController.deletePodcast);
router.get("/:id", podcastController.getPodcastById);
router.get("/featured", podcastController.getFeaturedPodcasts);


module.exports = router;
