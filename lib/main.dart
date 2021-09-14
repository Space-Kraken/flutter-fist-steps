import 'package:flutter/material.dart';
import 'package:practica2/src/screens/login_screen.dart';
import 'package:practica2/src/screens/opcion1_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/opc1': (BuildContext context) => opcion1Screen(),
      },
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
