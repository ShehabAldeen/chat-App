import 'package:chat_app/utils.dart';
import 'package:flutter/material.dart';

import 'custom_files/custom_text.dart';

class Registerscreen extends StatelessWidget {
  static final routeName = 'register screen';
  String? firstName;
  String? lastName;
  String? userName;
  String? email;
  String? password;
  var formKey = GlobalKey<FormState>();

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
        appBar: AppBar(
          title: CustomText(
            text: 'Create account',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'First Name',
                    ),
                    onChanged: (text) {
                      firstName = text;
                    },
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter first name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Last Name',
                    ),
                    onChanged: (text) {
                      lastName = text;
                    },
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter last name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'User Name',
                    ),
                    onChanged: (text) {
                      firstName = text;
                    },
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter user name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                    ),
                    onChanged: (text) {
                      email = text;
                    },
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter email';
                      }
                      if (Utils.isValidEmail(email ?? '')) {
                        return null;
                      }
                      return 'invalid email';
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                    ),
                    onChanged: (text) {
                      email = text;
                    },
                    validator: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please enter password';
                      }
                      if (text.length < 6) {
                        return 'should be at least 6 character';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() == true) {
                        createAccountWithFirebaseAuth();
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Create account'),
                          Icon(Icons.arrow_right),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void createAccountWithFirebaseAuth() {}
}
