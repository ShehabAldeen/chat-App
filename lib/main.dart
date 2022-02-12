import 'package:chat_app/login_screen.dart';
import 'package:chat_app/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
      ),
      routes: {
        Registerscreen.routeName: (context) => Registerscreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
      },
      initialRoute: LoginScreen.routeName,
    );
  }
}
