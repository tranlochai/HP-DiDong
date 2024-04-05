import 'package:flutter/material.dart';
import 'package:thikthp/src/Comm/comHelper.dart';
import 'package:thikthp/src/Comm/genTextFormField.dart';
import 'package:thikthp/src/DatabaseHandler/DbHelper.dart';
import 'package:thikthp/src/Model/UserModel.dart';
import 'package:thikthp/src/Screens/LoginForm.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DelAccount extends StatefulWidget {
  @override
  _DelAccountState createState() => _DelAccountState();
}

class _DelAccountState extends State<DelAccount> {
  final _formKey = GlobalKey<FormState>();
  Future<SharedPreferences> _pref = SharedPreferences.getInstance();

  late DbHelper dbHelper;
  final _conUserId = TextEditingController();
  final _conDelUserId = TextEditingController();
  final _conOldPassword = TextEditingController();
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
    });
  }

  delete() async {
    String delUserID = _conDelUserId.text;
    String enteredPassword = _conOldPassword.text;

    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      UserModel? currentUser = await dbHelper.getLoginUser(_conUserId.text, enteredPassword);

      if (currentUser == null) {
        setState(() {
          wrongPasswordAttempts++;

          if (wrongPasswordAttempts >= 5) {
            alertDialog(context, "Bạn đã nhập sai mật khẩu quá 5 lần. Vui lòng nhớ chính xác thông tin đăng nhập!");
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => LoginForm()),
                  (Route<dynamic> route) => false,
            );
          } else {
            alertDialog(context, "Chưa nhập đúng mật khẩu. Đã nhập sai $wrongPasswordAttempts lần.");
          }
        });
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
          child: Container(
            margin: EdgeInsets.only(top: 20.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 8.0,
              margin: EdgeInsets.all(16.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Delete
                        getTextFormField(
                          controller: _conDelUserId,
                          isEnable: false,
                          icon: Icons.person,
                          hintName: 'Tên tài khoản',
                        ),

                        SizedBox(height: 10.0),
                        getTextFormField(
                          controller: _conOldPassword,
                          icon: Icons.lock,
                          hintName: 'Mật khẩu hiện tại',
                          isObscureText: true,
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          margin: EdgeInsets.all(30.0),
                          width: double.infinity,
                          child: TextButton(
                            onPressed: delete,
                            child: Text(
                              'Xoá tài khoản',
                              style: TextStyle(color: Colors.white),
                            ),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors.blue),
                              shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      bottom: 1.0,
                      right: 1.0,
                      child: Container(
                        child: Icon(
                          Icons.delete,
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
