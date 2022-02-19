import 'dart:io';

import 'package:chat_app/add_room_screen.dart';
import 'package:chat_app/chat_details_screen.dart';
import 'package:chat_app/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'custom_files/custom_text.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = 'homeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initFirebaseCloudMessage();
  }

  void initFirebaseCloudMessage() {
    configIOSPlatForm();
    retriveToken();
    //app in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
  }

  void configIOSPlatForm() async {
    if (Platform.isIOS) {
      FirebaseMessaging messaging = FirebaseMessaging.instance;
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );
    }
  }

  void retriveToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print('Token $token');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage(
              'assets/images/SIGN IN – 1.png',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: CustomText(
              text: 'Route chat app',
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, AddRoomScreen.routeName);
            },
            child: Icon(Icons.add),
          ),
          body: StreamBuilder<QuerySnapshot<Room>>(
            stream: Room.withConverter().snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              var roomList = snapshot.data?.docs.map((e) => e.data()).toList();
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (buildContext, index) {
                  return RoomGridItem(roomList!.elementAt(index));
                },
                itemCount: roomList?.length ?? 0,
              );
            },
          ),
        ));
  }
}

class RoomGridItem extends StatelessWidget {
  Room room;

  RoomGridItem(this.room);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, ChatDetailsScreen.routeName,
            arguments: room);
      },
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: Colors.black45, offset: Offset(12, 12))
            ]),
        child: Column(
          children: [
            selectedCategoryImage(),
            CustomText(
              text: room.roomName,
            ),
          ],
        ),
      ),
    );
  }

  Widget selectedCategoryImage() {
    if (room.category == 'sport') {
      return Image.asset('assets/images/sport.jpg');
    }
    if (room.category == 'Movies') {
      return Image.asset('assets/images/movies_image.jpg');
    }
    return Image.asset('assets/images/music.jpg');
  }
}
