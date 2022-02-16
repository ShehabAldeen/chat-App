import 'package:chat_app/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  static String collectionName = 'messages';
  String id;
  String content;
  DateTime dateTime;
  String senderId;
  String sender;

  Message(
      {required this.id,
      required this.senderId,
      required this.content,
      required this.sender,
      required this.dateTime});

  Message.fromJson(Map<String, dynamic> json)
      : this(
            id: json['id'] as String,
            content: json['content'] as String,
            dateTime:
                DateTime.fromMillisecondsSinceEpoch((json['dateTime'] as int)),
            sender: json['sender'] as String,
            senderId: json['senderId'] as String);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'dateTime': dateTime.microsecondsSinceEpoch,
      'sender': sender,
      'senderId': senderId
    };
  }

  static CollectionReference<Message> withConverter(String roomId) {
    final messageRef = Room.withConverter()
        .doc(roomId)
        .collection(collectionName)
        .withConverter<Message>(
            fromFirestore: ((snapshot, _) =>
                Message.fromJson(snapshot.data()!)),
            toFirestore: (Message, _) => Message.toJson());
    return messageRef;
  }
}
