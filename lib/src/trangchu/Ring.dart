import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'RingForm.dart';

class Ring {
  String message;

  Ring({required this.message});

  void navigateToRingForm(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RingForm(message: message),
      ),
    );
  }
}