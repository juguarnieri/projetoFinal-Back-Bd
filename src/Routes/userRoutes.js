const express = require("express");
const router = express.Router();
const userController = require("../controllers/userController");

router.post("/", userController.createUser);
router.get("/:id", userController.getUserProfile);
//router.post("/:id/follow/:targetId", userController.followUser);
//router.delete("/:id/unfollow/:targetId", userController.unfollowUser);
//router.get("/", userController.getAllUsers);
//router.put("/:id", userController.updateUser);
//router.get("/:id/followers", userController.listFollowers);
//router.get("/:id/following", userController.listFollowing);

module.exports = router;
