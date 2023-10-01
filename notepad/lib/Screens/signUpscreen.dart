import 'package:flutter/material.dart';
import 'package:notepad/Screens/authscreen.dart';
import 'package:notepad/responsive.dart';
import 'authscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notepad/taost_utils.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  final emailcontroller = TextEditingController();
  final passcontroller = TextEditingController();
  final nameController = TextEditingController();
  bool loading = false;
  final _auth = FirebaseAuth.instance;
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
                        fontSize: 50),
                  ),
                  SizedBox(
                    height: getheight(context) * 0.1,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: getwidth(context) * 0.05,
                        right: getwidth(context) * 0.05),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field Required';
                        }
                        return null;
                      },
                      style: TextStyle(color: Colors.white),
                      controller: nameController,
                      cursorColor: Colors.white,
                      key: ValueKey('Username'),
                      decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(),
                              borderRadius: BorderRadius.circular(10)),
                          label: Text(
                            "Username",
                            style: TextStyle(color: Colors.white),
                          ),
                          hintText: "Tudora",
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                  SizedBox(
                    height: getheight(context) * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: getwidth(context) * 0.05,
                        right: getwidth(context) * 0.05),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field required';
                        } else if (!value.contains('@')) {
                          return 'Invalid email format';
                        }
                        return null;
                      },
                      style: TextStyle(color: Colors.white),
                      controller: emailcontroller,
                      cursorColor: Colors.white,
                      key: ValueKey('Email'),
                      decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(borderSide: BorderSide()),
                          label: Text(
                            "Email Address",
                            style: TextStyle(color: Colors.white),
                          ),
                          hintText: "Tudora@gmail.com",
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                  SizedBox(
                    height: getheight(context) * 0.02,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: getwidth(context) * 0.05,
                        right: getwidth(context) * 0.05),
                    child: TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Field is required';
                        } else if (value.length < 8) {
                          return 'Password length must be minimum 8 characters';
                        }
                        return null;
                      },
                      style: TextStyle(color: Colors.white),
                      controller: passcontroller,
                      cursorColor: Colors.white,
                      obscureText: true,
                      key: ValueKey('Password'),
                      decoration: InputDecoration(
                          errorStyle: TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(),
                              borderRadius: BorderRadius.circular(10)),
                          label: Text(
                            "Password",
                            style: TextStyle(color: Colors.white),
                          ),
                          hintText: "",
                          hintStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15))),
                    ),
                  ),
                  SizedBox(
                    height: getheight(context) * 0.03,
                  ),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        loading = true;
                      });
                      if (_formkey.currentState!.validate()) {
                        _auth
                            .createUserWithEmailAndPassword(
                                email: emailcontroller.text.toString(),
                                password: passcontroller.text.toString())
                            .then((value) {
                          setState(() {
                            loading = false;
                            toastMessage('Register Successfully');
                            nameController.clear();
                            emailcontroller.clear();
                            passcontroller.clear();
                          });
                        }).onError((error, stackTrace) {
                          setState(() {
                            loading = false;
                            toastMessage(error.toString());
                          });
                        });
                      } else {
                        setState(() {
                          loading = false;
                        });
                      }
                    },
                    child: Container(
                      height: getheight(context) * 0.06,
                      width: getwidth(context) * 0.8,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18)),
                      child: Center(
                          child: loading
                              ? CircularProgressIndicator(
                                  color: Colors.red,
                                )
                              : Text(
                                  "Register",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )),
                    ),
                  ),
                  SizedBox(
                    height: getheight(context) * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: TextStyle(color: Colors.white),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AuthScreen()));
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ))
                    ],
                  )
                ]),
          ),
        ),
      ),
    ));
  }
}
