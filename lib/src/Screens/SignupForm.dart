import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thikthp/src/Comm/comHelper.dart';
import 'package:thikthp/src/Comm/genLoginSignupHeader.dart';
import 'package:thikthp/src/Comm/genTextFormField.dart';
import 'package:thikthp/src/DatabaseHandler/DbHelper.dart';
import 'package:thikthp/src/Model/UserModel.dart';
import 'package:thikthp/src/Screens/LoginForm.dart';

class SignupForm extends StatefulWidget {
  @override
  _SignupFormState createState() => _SignupFormState();
}

class _SignupFormState extends State<SignupForm> {
  final _formKey = new GlobalKey<FormState>();

  final _conUserId = TextEditingController();
  final _conUserName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conPassword = TextEditingController();
  final _conCPassword = TextEditingController();
  var dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DbHelper();
  }

  signUp() async {
    String uid = _conUserId.text;
    String uname = _conUserName.text;
    String email = _conEmail.text;
    String passwd = _conPassword.text;
    String cpasswd = _conCPassword.text;

    if (_formKey.currentState?.validate() ?? false) {
      if (passwd != cpasswd) {
        alertDialog(context, 'Mật khẩu không khớp');
      } else {
        _formKey.currentState?.save();

        UserModel uModel = UserModel(uid, uname, email, passwd);
        await dbHelper.saveData(uModel).then((userData) {
          alertDialog(context, "Đã lưu thông tin thành công!");

          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => LoginForm()),
          );
        }).catchError((error) {
          print(error);
          alertDialog(context, "Tên tài khoản đã tồn tại trong hệ thống!");
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Color(0xFFFFF2E6),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            color: Color(0xFFFFF2E6),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 5.0),
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
                  SizedBox(height: 5.0),

                  Text(
                    ' Đăng kí ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 25.0,
                    ),
                  ),
                  SizedBox(height: 15.0),
                  getTextFormField(
                    controller: _conUserId,
                    icon: Icons.person,
                    hintName: 'Tên tài khoản',
                  ),
                  SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _conUserName,
                    icon: Icons.person_outline,
                    inputType: TextInputType.name,
                    hintName: 'Họ và tên',
                  ),
                  SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _conEmail,
                    icon: Icons.email,
                    inputType: TextInputType.emailAddress,
                    hintName: 'Email',
                  ),
                  SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _conPassword,
                    icon: Icons.lock,
                    hintName: 'Mật khẩu',
                    isObscureText: true,
                  ),
                  SizedBox(height: 10.0),
                  getTextFormField(
                    controller: _conCPassword,
                    icon: Icons.lock,
                    hintName: 'Nhắc lại mật khẩu ',
                    isObscureText: true,
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    margin: EdgeInsets.only(top: 10.0),
                    width: 350.0, // Set the desired width
                    child: TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                      ),
                      onPressed: signUp,
                      child: Text(
                        'Đăng kí',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Bạn đã có tài khoản? '),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.orange, // Set button color to orange
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => LoginForm()),
                                    (Route<dynamic> route) => false,
                              );
                            },
                            child: Text(
                              'Đăng nhập',
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
      ),
    );
  }
}
