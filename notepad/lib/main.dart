import 'package:flutter/material.dart';
import 'package:notepad/Screens/signUpscreen.dart';
import 'Screens/home.dart';
import 'Screens/authscreen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
  options: FirebaseOptions(
    apiKey: "AIzaSyB4HOHiKtS4Wy37HVW2B6ZJrPATSlXQ5e4", appId: "1:396926746426:android:e866f6b0608206c8469a03", 
    messagingSenderId: "396926746426", projectId: "notepad-app-cf354")
  );
  runApp(MyApp());
}

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
