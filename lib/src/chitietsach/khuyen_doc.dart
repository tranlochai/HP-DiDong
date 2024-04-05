import 'dart:math';
import 'package:thikthp/src/chitietsach/book_info.dart';
import 'package:thikthp/src/trangchu/my_home_page.dart';

class KhuyenDoc {
  static List<BookInfo> getRecommendedBooks() {
    List<BookInfo> allBooks = MyHomePage.allBooks; // Lấy danh sách allBooks từ MyHomePage

    // Xáo trộn danh sách sách
    allBooks.shuffle();

    // random 5 cuốn
    List<BookInfo> recommendedBooks = allBooks.take(5).toList();

    return recommendedBooks;
  }
}
