import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:thikthp/src/GiaoLuu/Post.dart';

class PostBai extends StatefulWidget {
  final Function(Post)? onPostCreated;
  final Post? initialPost;

  PostBai({Key? key, this.onPostCreated, this.initialPost}) : super(key: key);

  @override
  _PostBaiState createState() => _PostBaiState();
}

class _PostBaiState extends State<PostBai> {
  TextEditingController _contentController = TextEditingController();
  TextEditingController _commentController = TextEditingController();
  XFile? _image;

  @override
  void initState() {
    super.initState();

    if (widget.initialPost != null) {
      _contentController.text = widget.initialPost!.content;
    }
  }

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Viết bài đánh giá'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _contentController,
              decoration: InputDecoration(
                hintText: 'Nhập nội dung của bạn...',
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 20),
            _image != null
                ? Image.file(File(_image!.path))
                : Placeholder(
              fallbackHeight: 200,
              fallbackWidth: double.infinity,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _getImage();
              },
              child: Text('Chọn ảnh'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _addPost();
              },
              child: Text('Đăng Tải'),
            ),
          ],
        ),
      ),
    );
  }

  void _addPost() {
    String content = _contentController.text;
    int postId = widget.initialPost?.id ?? DateTime.now().millisecondsSinceEpoch;

    Post editedPost = Post(
      id: postId,
      content: content,
      imagePath: _image?.path,
      likes: widget.initialPost?.likes ?? 0,
      likedBy: widget.initialPost?.likedBy ?? [],
      comments: widget.initialPost?.comments ?? [], author: '',
    );

    widget.onPostCreated!(editedPost);
    _contentController.clear();
    _commentController.clear();
    setState(() {
      _image = null;
    });

    Navigator.pop(context, editedPost);
  }
}
