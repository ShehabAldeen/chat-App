import 'package:chat_app/firestore_utils.dart';
import 'package:chat_app/room.dart';
import 'package:chat_app/utils.dart';
import 'package:flutter/material.dart';
import 'custom_files/custom_text.dart';

class AddRoomScreen extends StatefulWidget {
  static final routeName = 'addRoomScreen';

  @override
  State<AddRoomScreen> createState() => _AddRoomScreenState();
}

class _AddRoomScreenState extends State<AddRoomScreen> {
  String selectedCategory = 'Enter Room description';
  var formKey = GlobalKey<FormState>();

  String roomName = '';

  String description = '';

  String category = '';

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
              text: 'Add Chat Room ',
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsets.all(24),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white,
              boxShadow: [BoxShadow(color: Colors.grey, offset: Offset(4, 4))],
            ),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomText(
                      text: 'Create a new room',
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                    Image.asset(
                      'assets/images/persons.png',
                      height: MediaQuery.of(context).size.height * 0.08,
                      fit: BoxFit.cover,
                    ),
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Room Name'),
                      onChanged: (text) {
                        roomName = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please enter Room Name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      maxLines: 4,
                      minLines: 4,
                      decoration:
                          InputDecoration(labelText: 'Enter Room description'),
                      onChanged: (text) {
                        description = text;
                      },
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return 'Please enter Room Description';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: 3),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: selectedCategory,
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          PopupMenuButton(itemBuilder: (context) {
                            return [
                              PopupMenuItem<int>(
                                  value: 0,
                                  child: rowOfPupMenu('Sport', Icons.sports)),
                              PopupMenuItem<int>(
                                  value: 1,
                                  child: rowOfPupMenu(
                                      'Movies', Icons.movie_creation_outlined)),
                              PopupMenuItem<int>(
                                  value: 2,
                                  child:
                                      rowOfPupMenu('Music', Icons.music_note)),
                            ];
                          }, onSelected: (value) {
                            if (value == 0) {
                              selectedCategory = 'sport';
                            } else if (value == 1) {
                              selectedCategory = 'Movies';
                            } else if (value == 2) {
                              selectedCategory = 'Music';
                            }
                          }),
                        ],
                      ),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Container(
                      width: MediaQuery.of(context).size.width * .70,
                      height: MediaQuery.of(context).size.height * .06,
                      child: ElevatedButton(
                          onPressed: () {
                            createRoom();
                            Navigator.pop(context);
                          },
                          child: Text('Create')),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget rowOfPupMenu(String text, IconData icon) {
    return Row(
      children: [
        Text(text),
        SizedBox(
          width: 100,
        ),
        Icon(
          icon,
          color: Colors.blue,
        )
      ],
    );
  }

  void createRoom() async {
    try {
      if (formKey.currentState!.validate()) {
        showLoading(context);
        var room = Room(
            id: '',
            description: description,
            category: selectedCategory,
            roomName: roomName);
        var roomRef = await addRoomToFirestore(room);
        hideLoading(context);
        return roomRef;
      }
    } catch (e) {
      showMessage(e.toString(), context);
    }
  }
}
