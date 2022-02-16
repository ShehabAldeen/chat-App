import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  static String collectionName = 'user';
  String id;
  String firstName;

  String lastName;

  String userName;

  String email;

  String password;

  UserData(
      {required this.userName,
      required this.password,
      required this.email,
      required this.id,
      required this.firstName,
      required this.lastName});

  UserData.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'] as String,
            firstName: json['firstName'] as String,
            lastName: json['lastName'] as String,
            userName: json['userName'] as String,
            password: json['password'] as String,
            email: json['email'] as String);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'userName': userName,
      'password': password,
      'email': email
    };
  }

  static CollectionReference<UserData> withConverter() {
    final usersRef = FirebaseFirestore.instance
        .collection(collectionName)
        .withConverter<UserData>(
          fromFirestore: (snapshot, _) => UserData.fromJson(snapshot.data()!),
          toFirestore: (UserData, _) => UserData.toJson(),
        );
    return usersRef;
  }
}
