import 'package:flutter/material.dart';
import 'package:thikthp/src/setting/Music.dart';

class MusicForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nhạc nền'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Music.playMusic();
          },
          child: Text('Phát nhạc'),
        ),
      ),
    );
  }
}
