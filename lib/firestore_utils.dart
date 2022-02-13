import 'package:chat_app/users.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addUserToFirestore(UserData user) {
  return UserData.withConverter().doc(user.id).set(user);
}

Future<UserData?> getUserById(String id) async {
  DocumentSnapshot<UserData> documentSnapshot =
      await UserData.withConverter().doc(id).get();
  return documentSnapshot.data();
}
