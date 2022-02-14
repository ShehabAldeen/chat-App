import 'package:chat_app/firestore_utils.dart';
import 'package:chat_app/users.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  UserData? user;

  AuthProvider() {
    fetchFirestoreUser();
  }

  void saveUserDataInProvider(UserData user) {
    this.user = user;
    notifyListeners();
  }

  void fetchFirestoreUser() async {
    if (FirebaseAuth.instance.currentUser != null) {
      var firestormUser =
          await getUserById(FirebaseAuth.instance.currentUser!.uid);
      user = firestormUser;
    }
  }

  bool isLoggedIn() {
    return FirebaseAuth.instance.currentUser != null;
  }
}
