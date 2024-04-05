import 'package:flutter/material.dart';
import 'package:thikthp/src/chitietsach/book_info.dart';
import 'package:thikthp/src/Read/GioiThieu.dart';

class BookmarkScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sách đã đánh dấu'),
      ),
      body: ListView.builder(
        itemCount: BookmarkList.bookmarks.length,
        itemBuilder: (context, index) {
          BookInfo book = BookmarkList.bookmarks[index];

          return ListTile(
            title: Text(book.title),
            subtitle: Text('${book.author} - ${book.category}'),
            leading: Image.asset(
              'assets/images/${book.cover}',
              width: 50,
              height: 70,
              fit: BoxFit.cover,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GioiThieuScreen(book: book),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
