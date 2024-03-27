import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lumine',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),

      //home: LoginSignupScreen(),
    );
  }
}