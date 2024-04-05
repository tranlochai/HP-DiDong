import 'package:flutter/material.dart';

class RingForm extends StatelessWidget {
  final String message;

  RingForm({required this.message});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thông báo'),
      ),
      body: Center(
        child: Text("Không có thông báo mới"),
      ),
    );
  }
}
