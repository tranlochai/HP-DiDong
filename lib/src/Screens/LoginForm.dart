import 'package:flutter/material.dart';
import 'package:thikthp/src/Comm/comHelper.dart';
import 'package:thikthp/src/Comm/genTextFormField.dart';
import 'package:thikthp/src/DatabaseHandler/DbHelper.dart';
import 'package:thikthp/src/Model/UserModel.dart';
import 'package:thikthp/src/Screens/SignupForm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thikthp/src/trangchu/my_home_page.dart';
import 'package:google_fonts/google_fonts.dart';

import '../setting/Music.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();
  final _formKey = GlobalKey<FormState>();

  final _conUserId = TextEditingController();
  final _conPassword = TextEditingController();
  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  login() async {
    String uid = _conUserId.text;
    String passwd = _conPassword.text;

    if (uid.isEmpty) {
      alertDialog(context, "Hãy nhập tên tài khoản");
    } else if (passwd.isEmpty) {
      alertDialog(context, "Hãy nhập mật khẩu");
    } else {
      await dbHelper.getLoginUser(uid, passwd).then((userData) {
        if (userData != null) {
          setSP(userData).whenComplete(() {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => MyHomePage(title: 'Đọc sách')),
                  (Route<dynamic> route) => false,
            );
          });
        } else {
          alertDialog(context, "Tên tài khoản hoặc mật khẩu không chính xác!");
        }
      }).catchError((error) {
        print(error);
        alertDialog(context, "Đăng nhập thất bại!");
      });
    }
  }

  Future setSP(UserModel user) async {
    final SharedPreferences sp = await _pref;

    sp.setString("user_id", user.user_id);
    sp.setString("user_name", user.user_name);
    sp.setString("email", user.email);
    sp.setString("password", user.password);
  }

  @override
  Widget build(BuildContext context) {
    Music.stopMusic();
    return Scaffold(
      body: Container(
        color: Color(0xFFFFF2E6),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Column(
                    children: [
                      SizedBox(height: 240.0),
                      Text(
                        'Sách Hay',
                        style: GoogleFonts.pacifico(
                          textStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.purple,
                            fontSize: 40.0,
                          ),
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Image.asset(
                        "assets/logo/logo1.jpg",
                        height: 150.0,
                        width: 150.0,
                      ),
                      SizedBox(height: 10.0),
                    ],
                  ),
                ),
                Text(
                  ' Đăng nhập ',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 25.0,
                  ),
                ),
                SizedBox(height: 10.0),
                getTextFormField(
                  controller: _conUserId,
                  icon: Icons.person,
                  hintName: 'Tên tài khoản',
                ),
                SizedBox(height: 10.0),
                getTextFormField(
                  controller: _conPassword,
                  icon: Icons.lock,
                  hintName: 'Mật khẩu',
                  isObscureText: true,
                ),
                Container(
                  margin: EdgeInsets.all(30.0),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green, // Màu xanh lá
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: login,
                    child: Text(
                      'Đăng nhập',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),

                Container(
                  margin: EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Bạn chưa có tài khoản? ',
                        style: TextStyle(color: Colors.black),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 15.0),
                        padding: EdgeInsets.all(1.0),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(40.0),
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (_) => SignupForm()),
                            );
                          },
                          child: Text(
                            'Đăng kí',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
