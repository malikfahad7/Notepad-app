import 'package:flutter/material.dart';
import 'Screens/home.dart';
import 'Screens/authscreen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light, primarySwatch: Colors.red),
      home: AuthScreen(),
    );
  }
}
