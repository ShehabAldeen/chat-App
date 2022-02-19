import 'package:chat_app/add_room_screen.dart';
import 'package:chat_app/chat_details_screen.dart';
import 'package:chat_app/login_screen.dart';
import 'package:chat_app/provider/auth_provider.dart';
import 'package:chat_app/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(ChangeNotifierProvider(
      create: (BuildContext context) => AuthProvider(), child: const MyApp()));
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProvider>(context);
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
        HomeScreen.routeName: (context) => HomeScreen(),
        AddRoomScreen.routeName: (context) => AddRoomScreen(),
        ChatDetailsScreen.routeName: (context) => ChatDetailsScreen(),
      },
      initialRoute:
          provider.isLoggedIn() ? HomeScreen.routeName : LoginScreen.routeName,
    );
  }
}
