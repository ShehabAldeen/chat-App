import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SentMessage extends StatelessWidget {
  String content;
  String dateTime;

  SentMessage(this.dateTime, this.content);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Text(
          this.dateTime,
          textAlign: TextAlign.right,
        )),
        Container(
          decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              )),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              content,
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ],
    );
  }
}
