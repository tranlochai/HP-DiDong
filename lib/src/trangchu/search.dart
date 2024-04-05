import 'package:flutter/material.dart';
import 'package:thikthp/src/Read/GioiThieu.dart';
import 'package:thikthp/src/chitietsach/book_info.dart';
import 'package:thikthp/src/trangchu/my_home_page.dart';

class SearchScreen extends StatelessWidget {
  final String keyword;

  SearchScreen({required this.keyword});

  List<BookInfo> searchBooks(String keyword) {
    String lowercaseKeyword = keyword.toLowerCase();

    // Tìm kiếm sách dựa trên từ khoá
    List<BookInfo> searchResults = MyHomePage.allBooks.where((book) {
      String lowercaseTitle = book.title.toLowerCase();
      String lowercaseAuthor = book.author.toLowerCase();
      String lowercaseCategory = book.category.toLowerCase();

      // So sánh chữ thường
      return lowercaseTitle.contains(lowercaseKeyword) ||
          lowercaseAuthor.contains(lowercaseKeyword) ||
          lowercaseCategory.contains(lowercaseKeyword);
    }).toList();

    return searchResults;
  }

  @override
  Widget build(BuildContext context) {
    List<BookInfo> searchResults = searchBooks(keyword);

    return Scaffold(
      appBar: AppBar(
        title: Text('Kết quả tìm kiếm'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kết quả cho: "$keyword"',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            _buildSearchResults(searchResults),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchResults(List<BookInfo> searchResults) {
    if (searchResults.isEmpty) {
      return Text(
        'Không có kết quả phù hợp.',
        style: TextStyle(fontWeight: FontWeight.w300),
      );
    } else {
      return Expanded(
        child: ListView.builder(
          itemCount: searchResults.length,
          itemBuilder: (context, index) {
            BookInfo book = searchResults[index];

            return Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
                side: BorderSide(color: Colors.grey),
              ),
              child: ListTile(
                title: Text(book.title),
                subtitle: Text('${book.author} - ${book.category}'),
                leading: Container(
                  width: 50,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    color: Colors.blue,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.asset(
                      'assets/images/${book.cover}',
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GioiThieuScreen(book: book),
                    ),
                  );
                },
              ),
            );
          },
        ),
      );
    }
  }
}
