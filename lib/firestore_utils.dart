import 'package:chat_app/message.dart';
import 'package:chat_app/room.dart';
import 'package:chat_app/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_screen.dart';

Future<void> addUserToFirestore(UserData user) {
  return UserData.withConverter().doc(user.id).set(user);
}

Future<void> addRoomToFirestore(Room room) {
  var decRef = Room.withConverter().doc();
  room.id = decRef.id;
  return decRef.set(room);
}

Future<UserData?> getUserById(String id) async {
  DocumentSnapshot<UserData> documentSnapshot =
      await UserData.withConverter().doc(id).get();
  return documentSnapshot.data();
}

Future<void> addMessageToFirestore(Message message, String roomId) {
  var docRef = Message.withConverter(roomId).doc();
  message.id = docRef.id;
  return docRef.set(message);
}

final FirebaseAuth _auth = FirebaseAuth.instance;

Future<void> logOut(BuildContext context) async {
  await _auth.signOut().then((value) => Navigator.of(context)
      .pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomeScreen()),
          (route) => false));
}
