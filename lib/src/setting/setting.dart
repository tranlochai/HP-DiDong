import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thikthp/src/setting/ChangeNotifier.dart';
import 'package:thikthp/src/Screens/LoginForm.dart';
import 'package:thikthp/src/setting/account.dart';
import 'package:thikthp/src/setting/delete_account.dart';

import 'package:thikthp/src/setting/Music.dart';

class SettingScreen extends StatefulWidget {
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          // Các cài đặt khác có thể thêm vào đây

          ListTile(
            leading: Icon(Icons.account_circle), // Icon trước nút
            title: Text('Tài khoản'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => Account()));
            },
          ),

          ListTile(
            leading: Icon(Icons.delete), // Icon trước nút
            title: Text('Xoá tài khoản'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => DelAccount()));
            },
          ),

          ListTile(
            leading: Icon(Icons.color_lens), // Icon trước nút
            title: Text('Màu nền'),
            onTap: () {
              // Khi nhấn vào "Màu nền", chuyển đổi giữa chế độ tối và chế độ sáng
              ThemeMode currentMode = Theme.of(context).brightness == Brightness.dark
                  ? ThemeMode.light
                  : ThemeMode.dark;

              // Cập nhật chế độ màu sắc
              context.read<ThemeNotifier>().setThemeMode(currentMode);
            },
          ),


          ListTile(
            leading: Icon(Icons.music_note),
            title: Text('Nhạc nền'),
            trailing: IconButton(
              icon: Icon(Icons.skip_next),
              onPressed: () {
                Music.nextTrack();
              },
            ),
            onTap: () {
              Music.playMusic();
            },
          ),



          ListTile(
            leading: Icon(Icons.exit_to_app), // Icon trước nút
            title: Text('Thoát'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => LoginForm()));
            },
          ),
        ],
      ),
    );
  }
}
