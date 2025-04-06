const express = require("express");
const router = express.Router();
const userController = require("../controllers/userController");

router.post("/", userController.createUser);
router.get("/", userController.getAllUsers);
router.get("/:id", userController.getUserProfile);
router.put("/:id", userController.updateUser);
router.delete("/:id", userController.deleteUser);
router.post("/:id/follow/:targetId", userController.followUser);
router.post("/:id/unfollow/:targetId", userController.unfollowUser);
router.get("/:id/followers", userController.listFollowers);
router.get("/:id/following", userController.listFollowing);


module.exports = router;
