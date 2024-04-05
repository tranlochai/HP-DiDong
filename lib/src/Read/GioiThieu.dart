import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:thikthp/src/chitietsach/book_info.dart';
import 'package:flutter/services.dart' show rootBundle, ByteData;
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class BookmarkList {
  static List<BookInfo> bookmarks = [];
}

class GioiThieuScreen extends StatefulWidget {
  final BookInfo book;

  GioiThieuScreen({required this.book});

  @override
  _GioiThieuScreenState createState() => _GioiThieuScreenState();
}

class _GioiThieuScreenState extends State<GioiThieuScreen> {
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    isBookmarked = BookmarkList.bookmarks.contains(widget.book);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.book.title),
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Image.asset(
                    'assets/images/${widget.book.cover}',
                    width: double.infinity,
                    height: 450,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Tên sách: ${widget.book.title}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Tác giả: ${widget.book.author}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text('Thể loại: ${widget.book.category}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text(
                'Nội dung sơ lược: ${widget.book.description}',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      _onBookmarkPressed(context, widget.book);
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.orangeAccent,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        isBookmarked ? 'Bỏ đánh dấu' : 'Đánh dấu',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _openPdf(context, widget.book);
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'Đọc',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      _downloadPdf(context, widget.book);
                    },
                    child: Container(
                      padding: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        'Tải về',
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onBookmarkPressed(BuildContext context, BookInfo book) {
    setState(() {
      if (isBookmarked) {
        BookmarkList.bookmarks.remove(book);
      } else {
        BookmarkList.bookmarks.add(book);
      }
      isBookmarked = !isBookmarked;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isBookmarked ? 'Đã bỏ đánh dấu sách: ${book.title}' : 'Đã đánh dấu sách: ${book.title}'),
      ),
    );
  }

  void _openPdf(BuildContext context, BookInfo book) async {
    try {
      final data = await rootBundle.load('assets/pdf/${book.pdfFileName}');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PdfViewPage(book: book, pdfData: data),
        ),
      );
    } catch (e) {
      print('Error loading PDF: $e');
    }
  }

  void _downloadPdf(BuildContext context, BookInfo book) async {
    try {
      final data = await rootBundle.load('assets/pdf/${book.pdfFileName}');
      final bytes = data.buffer.asUint8List();

      final directory = await getExternalStorageDirectory();
      final filePath = '${directory!.path}/${book.pdfFileName}';

      File file = File(filePath);
      await file.writeAsBytes(bytes);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Đã tải về sách: ${book.title} vào $filePath'),
        ),
      );
    } catch (e) {
      print('Error downloading PDF: $e');
    }
  }
}


class PdfViewPage extends StatelessWidget {
  final BookInfo book;
  final ByteData pdfData;

  PdfViewPage({required this.book, required this.pdfData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Đọc sách: ${book.title}'),
      ),
      body: PDFView(
        pdfData: pdfData.buffer.asUint8List(),
        autoSpacing: false,
        pageFling: false,
      ),
    );
  }
}
