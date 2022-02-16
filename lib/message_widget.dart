import 'package:chat_app/provider/auth_provider.dart';
import 'package:chat_app/recieve_message.dart';
import 'package:chat_app/sent_message.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'message.dart';

class MessageWidget extends StatelessWidget {
  Message message;

  MessageWidget(this.message);

  late AuthProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AuthProvider>(context);
    return Container(
        margin:
            EdgeInsets.only(bottom: MediaQuery.of(context).size.height * .03),
        child: message.senderId == provider.user!.id
            ? SentMessage(message.dateTime.toString(), message.content)
            : RecievedMessage(
                message.content, message.dateTime.toString(), message.sender));
  }
}
