const express = require("express");
const router = express.Router();
const aboutController = require("../controllers/aboutController");

router.get("/", aboutController.getAboutPage);
router.post("/", aboutController.createAbout);
router.put("/:id", aboutController.updateAbout);
router.post("/team", aboutController.addMember);
router.put("/team/:id", aboutController.updateMember);
router.get("/team/:id", aboutController.getMemberById);
router.delete("/team/:id", aboutController.deleteMember);

module.exports = router;
