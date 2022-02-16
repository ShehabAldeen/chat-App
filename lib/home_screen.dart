import 'package:chat_app/add_room_screen.dart';
import 'package:chat_app/chat_details_screen.dart';
import 'package:chat_app/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'custom_files/custom_text.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = 'homeScreen';

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
