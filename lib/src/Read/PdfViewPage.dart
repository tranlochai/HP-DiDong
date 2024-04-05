import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:thikthp/src/chitietsach/book_info.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: PDFView(
                pdfData: pdfData.buffer.asUint8List(),
                autoSpacing: false,
                pageFling: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
