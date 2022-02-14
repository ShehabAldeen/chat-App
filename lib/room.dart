import 'package:cloud_firestore/cloud_firestore.dart';

class Room {
  static String collectionName = 'room';
  String id;
  String roomName;
  String description;
  String category;

  Room(
      {required this.id,
      required this.description,
      required this.category,
      required this.roomName});

  Room.fromJson(Map<String, dynamic> json)
      : this(
          id: json['id'] as String,
          roomName: json['roomName'] as String,
          description: json['description'] as String,
          category: json['category'] as String,
        );

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'roomName': roomName,
      'description': description,
      'category': category
    };
  }

  static CollectionReference<Room> withConverter() {
    final roomRef = FirebaseFirestore.instance
        .collection(collectionName)
        .withConverter<Room>(
            fromFirestore: ((snapshot, _) => Room.fromJson(snapshot.data()!)),
            toFirestore: (Room, _) => Room.toJson());
    return roomRef;
  }
}
