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
router.get("/reports/videos/pdf", reportController.exportVideosPDF);
router.get("/reports/about/pdf", reportController.exportAboutPDF);


module.exports = router;

//http://localhost:3000/api/reports/  arquivo  /pdf