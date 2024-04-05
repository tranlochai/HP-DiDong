import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thikthp/src/GiaoLuu/Comment.dart';
import 'package:thikthp/src/GiaoLuu/Post.dart';
import 'package:thikthp/src/GiaoLuu/PostBai.dart';

class GiaoLuuScreen extends StatefulWidget {
  @override
  _GiaoLuuScreenState createState() => _GiaoLuuScreenState();
}

class _GiaoLuuScreenState extends State<GiaoLuuScreen> {
  late TextEditingController _commentController;
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    _commentController = TextEditingController();
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? postsJson = prefs.getString('posts');
    if (postsJson != null) {
      List<dynamic> postsData = jsonDecode(postsJson);
      setState(() {
        posts = postsData.map((data) => Post.fromJson(data)).toList();
      });
    }
  }

  Future<void> _savePosts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String postsJson = jsonEncode(posts);
    prefs.setString('posts', postsJson);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Giao Lưu'),
      ),
      body: posts.isNotEmpty
          ? ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return _buildPostCard(posts[index]);
        },
      )
          : Center(
        child: Text('Không có bài viết nào. Hãy thêm một bài viết mới!'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 32.0,
              child: FloatingActionButton(
                onPressed: () {
                  _navigateToPostBaiScreen();
                },
                child: Text('Thêm bài viết'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[],
        ),
      ),
    );
  }

  Widget _buildPostCard(Post post) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.content,
              style: TextStyle(fontSize: 18),
            ),
            if (post.imagePath != null)
              Image.file(
                File(post.imagePath!),
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 10),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    _likePost(post);
                  },
                  icon: Icon(Icons.thumb_up),
                ),
                Text('${post.likes} Thích'),
              ],
            ),
            _buildCommentSection(post),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    _editPost(post);
                  },
                  child: Text('Chỉnh sửa'),
                ),
                TextButton(
                  onPressed: () {
                    _deletePost(post);
                  },
                  child: Text('Xoá'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _deletePost(Post post) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Xác nhận xoá'),
        content: Text('Bạn có chắc chắn muốn xoá bài viết này?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                posts.remove(post);
              });
              _savePosts();
              Navigator.pop(context);
            },
            child: Text('Đồng ý'),
          ),
        ],
      ),
    );
  }

  Widget _buildCommentSection(Post post) {
    TextEditingController _commentController = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Bình luận:',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 10),
        for (var comment in post.comments)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Text(
              '${comment.author}: ${comment.content}',
              style: TextStyle(fontSize: 14),
            ),
          ),
        SizedBox(height: 10),
        ElevatedButton(
          onPressed: () async {
            String? result = await _addComment(post, _commentController);
            if (result != null) {
            }
          },
          child: Text('Thêm bình luận'),
        ),
      ],
    );
  }

  _likePost(Post post) {
    if (post.likedBy.contains('currentUserId')) {
      setState(() {
        post.likes--;
        post.likedBy.remove('currentUserId');
      });
    } else {
      setState(() {
        post.likes++;
        post.likedBy.add('currentUserId');
      });
    }
    _savePosts();
  }
  void _editPost(Post post) async {
    final editedPost = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostBai(
          initialPost: post,
          onPostCreated: (editedPost) {
            int index = posts.indexWhere((p) => p.id == editedPost.id);
            if (index != -1) {
              setState(() {
                posts[index] = editedPost;
              });
              _savePosts();
            }
          },
        ),
      ),
    );

    print('Kết quả từ màn hình chỉnh sửa: $editedPost');
  }


  _addComment(Post post, TextEditingController commentController) async {
    bool cancel = false;

    String? commentContent = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Thêm bình luận'),
        content: TextField(
          controller: commentController,
          decoration: InputDecoration(hintText: 'Nhập nội dung bình luận...'),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              cancel = true;
              Navigator.of(context).pop();
            },
            child: Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(commentController.text);
            },
            child: Text('Thêm'),
          ),
        ],
      ),
    );

    if (!cancel && commentContent != null) {
      setState(() {
        post.comments.add(
          Comment(
            author: 'Người dùng',
            content: commentContent,
          ),
        );
      });
      commentController.clear();
      _savePosts();
    }
  }

  _navigateToPostBaiScreen() async {
    final newPost = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostBai(
          onPostCreated: (post) {
            setState(() {
              posts.add(post);
            });
            _savePosts();
          },
        ),
      ),
    );

    print('Kết quả từ màn hình PostBai: $newPost');
  }

  _navigateToAllReviewsScreen() {
    // Chuyển hướng đến màn hình hiển thị tất cả đánh giá
    // (Bạn có thể triển khai màn hình này theo yêu cầu của bạn)
  }
}
