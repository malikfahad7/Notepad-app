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
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          elevation: 0.5,
          hoverColor: Colors.redAccent,
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
                ))
          ],
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu, weight: 10, size: 30),
          ),
          backgroundColor: Colors.red,
          title: Padding(
            padding: EdgeInsets.only(right: 0),
            child: Center(
              child: Text(
                "Tudora",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
