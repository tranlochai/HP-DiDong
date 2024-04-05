import 'package:flutter/material.dart';
import 'package:thikthp/src/Comm/comHelper.dart';
import 'package:thikthp/src/Comm/genTextFormField.dart';
import 'package:thikthp/src/DatabaseHandler/DbHelper.dart';
import 'package:thikthp/src/Model/UserModel.dart';
import 'package:thikthp/src/Screens/LoginForm.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  final _formKey = GlobalKey<FormState>();
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  late DbHelper dbHelper;
  final _conUserId = TextEditingController();
  final _conDelUserId = TextEditingController();
  final _conUserName = TextEditingController();
  final _conEmail = TextEditingController();
  final _conOldPassword = TextEditingController();
  final _conNewPassword = TextEditingController();
  final _conConfirmPassword = TextEditingController();
  int wrongPasswordAttempts = 0;

  @override
  void initState() {
    super.initState();
    getUserData();

    dbHelper = DbHelper();
  }

  Future<void> getUserData() async {
    final SharedPreferences sp = await _pref;

    setState(() {
      _conUserId.text = sp.getString("user_id")!;
      _conDelUserId.text = sp.getString("user_id")!;
      _conUserName.text = sp.getString("user_name")!;
      _conEmail.text = sp.getString("email")!;
    });
  }

  update() async {
    String uid = _conUserId.text;
    String uname = _conUserName.text;
    String email = _conEmail.text;
    String oldPassword = _conOldPassword.text;
    String newPassword = _conNewPassword.text;
    String confirmPassword = _conConfirmPassword.text;

    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      UserModel? currentUser = await dbHelper.getLoginUser(uid, oldPassword);

      if (currentUser == null) {
        alertDialog(context, "Mật khẩu cũ không chính xác.");
        return;
      }
      if (newPassword != confirmPassword) {
        alertDialog(context, "Mật khẩu mới và xác nhận mật khẩu không khớp.");
      } else {
        _formKey.currentState!.save();

        UserModel user = UserModel(uid, uname, email, newPassword);
        await dbHelper.updateUser(user).then((value) {
          if (value == 1) {
            alertDialog(context, "Cập nhật thành công!");

            updateSP(user, true).whenComplete(() {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginForm()),
                    (Route<dynamic> route) => false,
              );
            });
          } else {
            alertDialog(context, "Cập nhật thất bại!");
          }
        }).catchError((error) {
          print(error);
          alertDialog(context, "Đã xảy ra lỗi!");
        });
      }
    }
  }

  delete() async {
    String delUserID = _conDelUserId.text;
    String oldPassword = _conOldPassword.text;

    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      if (oldPassword != _conOldPassword.text) {
        setState(() {
          wrongPasswordAttempts++;
        });

        if (wrongPasswordAttempts >= 5) {
          alertDialog(
            context,
            "Bạn đã nhập sai mật khẩu quá 5 lần. Quay lại trang đăng nhập.",
          );
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => LoginForm()),
                (Route<dynamic> route) => false,
          );
        } else {
          alertDialog(
            context,
            "Mật khẩu cũ không chính xác. Đã nhập sai $wrongPasswordAttempts lần.",
          );
        }
      } else {
        await dbHelper.deleteUser(delUserID).then((value) {
          if (value == 1) {
            alertDialog(context, "Đã xoá tài khoản!");

            updateSP(null, false).whenComplete(() {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => LoginForm()),
                    (Route<dynamic> route) => false,
              );
            });
          }
        });
      }
    }
  }

  Future updateSP(UserModel? user, bool add) async {
    final SharedPreferences sp = await _pref;

    if (add) {
      sp.setString("user_name", user!.user_name);
      sp.setString("email", user.email);
      sp.setString("password", user.password);
    } else {
      sp.remove('user_id');
      sp.remove('user_name');
      sp.remove('email');
      sp.remove('password');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tài khoản'),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Center(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 8.0,
                    margin: EdgeInsets.all(16.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.only(bottom: 20),
                            child: Transform.rotate(
                              angle: 0.1,
                              child: Text(
                                'Thông tin cá nhân',
                                style: TextStyle(
                                  color: Colors.deepPurple,
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'QwigleyRegular',
                                ),
                              ),
                            ),
                          ),
                          getTextFormField(
                            controller: _conUserId,
                            isEnable: false,
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
                            controller: _conOldPassword,
                            icon: Icons.lock,
                            hintName: 'Mật khẩu hiện tại',
                            isObscureText: true,
                          ),
                          SizedBox(height: 10.0),
                          getTextFormField(
                            controller: _conNewPassword,
                            icon: Icons.lock,
                            hintName: 'Mật khẩu mới',
                            isObscureText: true,
                          ),
                          SizedBox(height: 10.0),
                          getTextFormField(
                            controller: _conConfirmPassword,
                            icon: Icons.lock,
                            hintName: 'Xác nhận mật khẩu mới',
                            isObscureText: true,
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            margin: EdgeInsets.all(30.0),
                            width: double.infinity,
                            child: TextButton(
                              onPressed: update,
                              child: Text(
                                'Cập nhật',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(Colors.blue),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.0),
                                  ),
                                ),
                                overlayColor: MaterialStateProperty.resolveWith(
                                      (Set<MaterialState> states) {
                                    if (states.contains(MaterialState.hovered)) {
                                      return Colors.blue.withOpacity(0.4);
                                    }
                                    return Colors.transparent;
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 16,
                top: 16,
                child: Icon(
                  Icons.push_pin,
                  size: 40,
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
