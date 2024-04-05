import 'package:flutter/material.dart';

class genLoginSignupHeader extends StatelessWidget {
  final String headerName;

  genLoginSignupHeader(this.headerName);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(height: 50.0),
          Text(
            headerName,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 40.0,
              fontFamily: 'PacificoRegular',
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
    );
  }
}
