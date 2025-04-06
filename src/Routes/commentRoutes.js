const express = require("express");
const router = express.Router();
const commentController = require("../controllers/commentController");

router.get("/", commentController.getAllComments); 
router.get("/post/:postId", commentController.getCommentsByPost);
router.get("/:id", commentController.getCommentById);
router.post("/", commentController.createComment);
router.put("/:id", commentController.updateComment);
router.delete("/:id", commentController.deleteComment);
router.get("/post/:postId/count", commentController.getCommentsCount);

module.exports = router;
