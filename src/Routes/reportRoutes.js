const express = require("express");
const router = express.Router();
const reportController = require("../controllers/reportController");

router.get("/reports/users/pdf", reportController.exportUsersPDF);

module.exports = router;
