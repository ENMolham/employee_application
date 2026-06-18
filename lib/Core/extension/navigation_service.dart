import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  Future<dynamic> push(Widget page) {
    return Navigator.of(this).push(MaterialPageRoute(builder: (_) => page));
  }

  Future<dynamic> pushReplacement(Widget page) {
    return Navigator.of(
      this,
    ).pushReplacement(MaterialPageRoute(builder: (_) => page));
  }

  Future<dynamic> pushAndRemoveUntil(Widget page) {
    return Navigator.of(this).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => page),
      (route) => false,
    );
  }

  void pop() {
    Navigator.of(this).pop();
  }
}
