import 'package:chat_app/firestore_utils.dart';
import 'package:chat_app/login_screen.dart';
import 'package:chat_app/message_widget.dart';
import 'package:chat_app/provider/auth_provider.dart';
import 'package:chat_app/register_screen.dart';
import 'package:chat_app/room.dart';
import 'package:chat_app/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'custom_files/custom_text.dart';
import 'home_screen.dart';
import 'message.dart';

class ChatDetailsScreen extends StatefulWidget {
  static String routeName = 'chat details room';

  @override
  State<ChatDetailsScreen> createState() => _ChatDetailsScreenState();
}

class _ChatDetailsScreenState extends State<ChatDetailsScreen> {
  String message = '';

  late AuthProvider provider;

  late Room room;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AuthProvider>(context);
    room = ModalRoute.of(context)!.settings.arguments as Room;
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
                text: ' Chat Details Room ',
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              actions: [
                InkWell(
                    onTap: () {
                      logOut(context);
                      showMessage('Account is deleted successfully', context);
                    },
                    child: Icon(Icons.logout))
              ],
            ),
            body: Container(
              padding: EdgeInsets.all(12),
              child: Column(
                children: [
                  Expanded(
                      child: Container(
                    child: StreamBuilder<QuerySnapshot<Message>>(
                      stream: Message.withConverter(room.id).snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          Text(snapshot.hasError.toString());
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        var date =
                            snapshot.data!.docs.map((e) => e.data()).toList();
                        return ListView.builder(
                            itemBuilder: (context, index) {
                              return MessageWidget(date[index]);
                            },
                            itemCount: date.length);
                      },
                    ),
                  )),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: TextEditingController(
                            text: message,
                          ),
                          onChanged: (text) {
                            message = text;
                          },
                          decoration: InputDecoration(
                            hintText: 'Type our message',
                            focusColor: Colors.grey,
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(12)),
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 1)),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * .07,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            sendMessage();
                          },
                          child: Row(
                            children: [
                              Text('Send'),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * .03,
                              ),
                              Icon(Icons.send)
                            ],
                          ))
                    ],
                  ),
                ],
              ),
            )));
  }

  void sendMessage() async {
    Message message = Message(
        id: '',
        content: this.message,
        senderId: provider.user!.id,
        sender: provider.user!.userName,
        dateTime: DateTime.now());
    var res = await addMessageToFirestore(message, room.id);
    this.message = '';
    setState(() {});
  }
}
