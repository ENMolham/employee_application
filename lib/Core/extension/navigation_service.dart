import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

extension NavigationExtension on BuildContext {
  void goTo(String path) => go(path);
  void pushTo(String path) => push(path);
  void popPage() => pop();
}
