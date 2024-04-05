import 'package:flutter/material.dart';

import 'Comment.dart';

class Post {
  int id;
  String content;
  String? imagePath;
  int likes;
  List<Comment> comments;
  List<String> likedBy;
  String author;

  Post({
    required this.id,
    required this.content,
    this.imagePath,
    this.likes = 0,
    this.comments = const [],
    this.likedBy = const [],
    required this.author,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'imagePath': imagePath,
      'likes': likes,
      'comments': comments.map((comment) => comment.toJson()).toList(),
      'likedBy': likedBy,
      'author': author,
    };
  }

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      content: json['content'],
      imagePath: json['imagePath'],
      likes: json['likes'],
      comments: (json['comments'] as List).map((comment) => Comment.fromJson(comment)).toList(),
      likedBy: (json['likedBy'] as List).cast<String>(),
      author: json['author'],
    );
  }
}
