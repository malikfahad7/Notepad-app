import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:notepad/responsive.dart';
import 'package:notepad/taost_utils.dart';
import 'package:notepad/database.dart';

class HomeScreen extends StatefulWidget {
  final String uid;
  const HomeScreen({required this.uid, super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formkey = GlobalKey<FormState>();
  final TitleController = TextEditingController();
  final DescriptionController = TextEditingController();
  bool loading = false;
  late List<DocumentSnapshot> _userTasks=[];
  @override
  void initState() {
    super.initState();
    _getTasks();  //Getting tasks of curren User
  }

  Future<void> _getTasks() async{
    QuerySnapshot snapshot = await FirebaseFirestore
        .instance.collection("Todo").doc(widget.uid)
        .collection("tasks").get();
    setState(() {
      _userTasks = snapshot.docs;
    });

  }
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
          onPressed: () {
            openDialog();
          },
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
                  Icons.logout,
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
        body: _userTasks !=null
            ? ListView.builder(
          itemCount: _userTasks.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_userTasks[index]['title']),
              subtitle: Text(_userTasks[index]['description']),
              // Display other task details as needed
            );
          },
        )
            : Center(child: Text('No Tasks yet')),
      ),
    );

  }
  void openDialog() => showDialog(context: context,
  builder: (context) => AlertDialog(
    backgroundColor: Colors.red,
    content: Container(

      height: getheight(context)*0.45,
      width: getwidth(context)*0.7,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Add Task', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold,
          color: Colors.white),),

          Form(
            key: _formkey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      left: getwidth(context) * 0.02,
                      right: getwidth(context) * 0.02),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field required';
                      }
                      return null;
                    },
                    style: TextStyle(color: Colors.white),
                    controller: TitleController,
                    cursorColor: Colors.white,
                    key: ValueKey('Title'),
                    decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(borderSide: BorderSide()),
                        label: Text(
                          "Title",
                          style: TextStyle(color: Colors.white),
                        ),
                        hintText: "eg: Shopping Items",
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(15)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: getwidth(context) * 0.02,
                      right: getwidth(context) * 0.02,
                  top: getwidth(context)*0.04),
                  child: TextFormField(

                    maxLength: 50,
                    maxLines: 5,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Field required';
                      }
                      return null;
                    },
                    style: TextStyle(color: Colors.white),
                    controller: DescriptionController,
                    cursorColor: Colors.white,
                    key: ValueKey('Description'),
                    decoration: InputDecoration(
                        errorStyle: TextStyle(color: Colors.white),
                        border: OutlineInputBorder(borderSide: BorderSide()),
                        hintStyle: TextStyle(color: Colors.white),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(15)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(15))),
                  ),
                ),
                InkWell(
                  onTap: () async{
                    setState(() {
                      loading = true;
                    });
                 if(_formkey.currentState!.validate()){
                   Map<String, dynamic> taskInfo={
                     "title": TitleController.text,
                     "description": DescriptionController.text
                   };
                   await DatabaseMethods().addTask(taskInfo, widget.uid).then((value) {
                     setState(() {
                       loading= false;
                       Navigator.of(context).pop();
                       toastMessage("Task added");
                       TitleController.clear();
                       DescriptionController.clear();
                     });
                   }).onError((error, stackTrace) {
                     setState(() {
                       loading = false;
                       toastMessage(error.toString());
                     });
                   });
                 }
                 else {
                   setState(() {
                     loading = false;
                   });
                 }
                  },
                  child: Container(
                    height: getheight(context)*0.06,
                    width: getwidth(context)*0.65,
                    decoration: BoxDecoration(
                        color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: loading?
                      CircularProgressIndicator(
                        color: Colors.red,
                      )
                          :Text('Add', style: TextStyle(color: Colors.red,
                      fontSize: 16, fontWeight: FontWeight.w800),),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    ),
  )
  );
}
