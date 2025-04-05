const express = require("express");
const router = express.Router();

const podcastController = require("../controllers/podcastController");

router.get("/", podcastController.getAllPodcasts);
//router.get("/category/:category", podcastController.getByCategory);
router.post("/", podcastController.createPodcast);

module.exports = router;
