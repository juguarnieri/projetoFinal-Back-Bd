const express = require("express");
const router = express.Router();
const reportController = require("../controllers/reportController");

router.get("/reports/users/pdf", reportController.exportUsersPDF);
router.get("/reports/users/pdf", reportController.exportUsersPDF);
router.get("/reports/posts/pdf", reportController.exportPostsPDF);

module.exports = router;
