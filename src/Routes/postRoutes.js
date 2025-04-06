const express = require("express");
const router = express.Router();
const postController = require("../controllers/postController");

router.post("/", postController.createPost);
router.get("/usuario/:userId", postController.getUserPosts);
router.post("/:postId/like/:userId", postController.likePost);
router.delete("/:postId/unlike/:userId", postController.unlikePost);
router.get("/:postId/likes", postController.getLikesCount);
router.get("/", postController.getAllPosts);


module.exports = router;
