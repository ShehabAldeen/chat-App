import 'package:flutter/material.dart';

class RecievedMessage extends StatelessWidget {
  String content;
  String dateTime;
  String senderName;

  RecievedMessage(this.content, this.dateTime, this.senderName);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(senderName),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(24),
                    topLeft: Radius.circular(0),
                    topRight: Radius.circular(24),
                  )),
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 4),
                padding: EdgeInsets.all(12),
                child: Text(
                  content,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ),
            Expanded(
                child: Text(
              this.dateTime,
              textAlign: TextAlign.right,
            )),
          ],
        ),
      ],
    );
  }
}
