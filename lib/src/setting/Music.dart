import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Music {
  static final _assetsAudioPlayer = AssetsAudioPlayer();
  static bool _isPlaying = false;
  static bool _nextPressed = false; // Biến để kiểm tra xem nút "next" đã được nhấn hay không

  static final List<String> trackList = [
    'assets/music/acarina.mp3',
    'assets/music/canon.mp3',
    // Add other tracks as needed
  ];

  static int _currentTrackIndex = 0;

  static void playMusic() {
    if (!_isPlaying) {
      _assetsAudioPlayer.open(
        Audio(trackList[_currentTrackIndex]),
        autoStart: true,
        showNotification: true,
      );

      // Listen for the currentPosition event to check if the current track has reached the end
      _assetsAudioPlayer.currentPosition.listen((currentPosition) {
        final totalDuration = _assetsAudioPlayer.current.value?.audio?.duration;

        if (currentPosition == totalDuration && !_nextPressed) {
          // Nếu đang không có nút "next" được nhấn, chuyển lại bài hát hiện tại
          _currentTrackIndex = (_currentTrackIndex + 1) % trackList.length;
          _assetsAudioPlayer.open(
            Audio(trackList[_currentTrackIndex]),
            autoStart: true,
            showNotification: true,
          );
        }

        // Reset biến _nextPressed
        _nextPressed = false;
      });

      _isPlaying = true;
    } else {
      _assetsAudioPlayer.playOrPause();
    }
  }

  static void nextTrack() {
    print('Next track pressed');
    _nextPressed = true; // Đánh dấu là nút "next" đã được nhấn
    _assetsAudioPlayer.stop(); // Stop the current track

    // Check if there is a next track
    if (_currentTrackIndex + 1 < trackList.length) {
      _currentTrackIndex++;
    } else {
      // If no next track, go back to the first track
      _currentTrackIndex = 0;
    }

    _assetsAudioPlayer.open(
      Audio(trackList[_currentTrackIndex]),
      autoStart: true,
      showNotification: true,
    );

    _isPlaying = true;
  }

  static void stopMusic() {
    _assetsAudioPlayer.stop();
  }

  static void dispose() {
    _assetsAudioPlayer.dispose();
  }
}

class MusicForm extends StatefulWidget {
  @override
  _MusicFormState createState() => _MusicFormState();
}

class _MusicFormState extends State<MusicForm> {
  @override
  void dispose() {
    Music.dispose(); // Dừng phát nhạc khi Widget bị huỷ
    super.dispose();
  }

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