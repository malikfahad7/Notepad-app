import 'package:flutter/material.dart';
import 'package:notepad/responsive.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.red,
      body: SingleChildScrollView(
        child: Container(
          height: getheight(context),
          width: getwidth(context),
          child: Form(
            key: _formkey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Tudora",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 35),
                  ),
                  SizedBox(
                    height: getheight(context) * 0.1,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: getwidth(context) * 0.05,
                        right: getwidth(context) * 0.05),
                    child: TextFormField(),
                  ),
                ]),
          ),
        ),
      ),
    ));
  }
}
