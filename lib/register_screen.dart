import 'package:flutter/material.dart';

import 'custom_files/custom_text.dart';

class Registerscreen extends StatelessWidget {
  static final routeName = 'register screen';

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
          )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: CustomText(
            text: 'Create account',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          centerTitle: true,
        ),
      ),
    );
  }
}
