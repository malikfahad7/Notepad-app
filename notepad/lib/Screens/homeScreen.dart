import 'package:flutter/material.dart';
import 'package:notepad/responsive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildConteontext) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          onPressed: () {},
          elevation: 0.5,

          child: Center(
              child: Icon(
            Icons.add,
            weight: 5,
          )),
        ),
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.info,
                  weight: 10,
                  size: 30,
                  color: Colors.white,
                ))
          ],
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu, weight: 10, size: 30, color: Colors.white,),
          ),
          backgroundColor: Colors.red,
          title: Padding(
            padding: EdgeInsets.only(right: 0),
            child: Center(
              child: Text(
                "Tudora",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
          elevation: 0.5,
          toolbarHeight: 100,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            child: Container(
          height: getheight(context),
          width: getwidth(context),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(
              height: getheight(context) * 0.38,
            ),
            Text(
              'Nothing to Show',
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ]),
        )),
      ),
    );
  }
}
