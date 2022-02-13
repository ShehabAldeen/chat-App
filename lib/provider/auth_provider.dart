import 'package:chat_app/users.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  UserData? user;

  void saveUserDataInProvider(UserData user) {
    this.user = user;
    notifyListeners();
  }
}
