const express = require("express");
const router = express.Router();
const reportController = require("../controllers/reportController");

router.get("/reports/users/pdf", reportController.exportUsersPDF);
router.get("/reports/users/pdf", reportController.exportUsersPDF);
router.get("/reports/posts/pdf", reportController.exportPostsPDF);
router.get("/reports/users/pdf", reportController.exportUsersPDF);
router.get("/reports/posts/pdf", reportController.exportPostsPDF);
router.get("/reports/comments/pdf", reportController.exportCommentsPDF);
router.get("/reports/news/pdf", reportController.exportNewsPDF);
router.get("/reports/podcasts/pdf", reportController.exportPodcastsPDF);

module.exports = router;
