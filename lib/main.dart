import 'package:flutter/material.dart';
import 'package:phoneauth/Screens/welcome_screen.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Phone Auth",
      home: WelcomeScreen(),
    );
  }
}
