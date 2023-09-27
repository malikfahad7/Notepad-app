import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Todura",style: TextStyle(color: Colors.white),)),
        elevation: 1.5,
        toolbarHeight: 70,
      ),
      body: Container(
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){},
      elevation: 1.5,child: Center(child: Icon(Icons.add)),),
    );
  }
}
