import 'package:flutter/material.dart';

class Comment {
  String author;
  String content;

  Comment({
    required this.author,
    required this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'author': author,
      'content': content,
    };
  }

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      author: json['author'],
      content: json['content'],
    );
  }
}
