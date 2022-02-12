import 'package:chat_app/users.dart';

Future<void> addUserToFirestore(UserData user) {
  return UserData.withConverter().doc(user.id).set(user);
}
