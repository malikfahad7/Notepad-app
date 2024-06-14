import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notepad/Screens/authscreen.dart';
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
 //Getting Tasks From Firebase.....
  Future<void> _getTasks() async{
    QuerySnapshot snapshot = await FirebaseFirestore
        .instance.collection("Todo").doc(widget.uid)
        .collection("tasks").get();
    setState(() {
      _userTasks = snapshot.docs;
    });
  }
  //Updating Task From Firebase.....
  void updateDialog(DocumentSnapshot taskDoc) => showDialog(
    context: context,
    builder: (context) {
      final TitleController = TextEditingController(text: taskDoc['title']);
      final DescriptionController = TextEditingController(text: taskDoc['description']);
      return AlertDialog(
        backgroundColor: Colors.red,
        content: Container(
          height: getheight(context) * 0.45,
          width: getwidth(context) * 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Update Task',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
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
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: getwidth(context) * 0.02,
                        right: getwidth(context) * 0.02,
                        top: getwidth(context) * 0.04,
                      ),
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
                              borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        setState(() {
                          loading = true;
                        });
                        if (_formkey.currentState!.validate()) {
                          Map<String, dynamic> updatedTaskInfo = {
                            "title": TitleController.text,
                            "description": DescriptionController.text,
                          };
                          await FirebaseFirestore.instance
                              .collection("Todo")
                              .doc(widget.uid)
                              .collection("tasks")
                              .doc(taskDoc.id)
                              .update(updatedTaskInfo)
                              .then((value) {
                            setState(() {
                              loading = false;
                              Navigator.of(context).pop();
                              toastMessage("Task updated");
                              TitleController.clear();
                              DescriptionController.clear();
                            });
                            // Refresh the task list
                            _getTasks();
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
                        width: getwidth(context) * 0.65,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: loading
                              ? CircularProgressIndicator(
                            color: Colors.red,
                          )
                              : Text(
                            'Update',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.w800),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
  //Deleting task from Firebase....
  Future<void> deleteTask(String taskId) async {
    await FirebaseFirestore.instance
        .collection("Todo")
        .doc(widget.uid)
        .collection("tasks")
        .doc(taskId)
        .delete()
        .then((_) {
      toastMessage("Task deleted");
      _getTasks(); // Refresh the task list
    }).catchError((error) {
      toastMessage("Failed to delete task: $error");
    });
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(

                decoration: BoxDecoration(

                  color: Colors.red,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [

                    CircleAvatar(
                      backgroundImage: NetworkImage('https://cdn.vectorstock.com/i/500p/53/42/user-member-avatar-face-profile-icon-vector-22965342.jpg'), backgroundColor: Colors.white,
                    maxRadius: 40, ),
                    Text(FirebaseAuth.instance.currentUser!.email.toString(), style: TextStyle(color: Colors.white, fontSize: 16),)
                  ],
                )
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),

              ListTile(
                leading: Icon(Icons.logout_sharp),
                title: Text('Sign Out'),
                onTap: () async{
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> AuthScreen()), (route) => false);

                },
              ),
            ],
          ),
        ),
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
                onPressed: () async{
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> AuthScreen()), (route) => false);
                },
                icon: Icon(
                  Icons.logout,
                  weight: 10,
                  size: 30,
                  color: Colors.white,
                ))
          ],
          leading: Builder(
    builder: (context) => IconButton(
    icon: Icon(
    Icons.menu,
    weight: 10,
    size: 30,
    color: Colors.white,
    ),
    onPressed: () {
    Scaffold.of(context).openDrawer();
    },
    ),
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
        body: _userTasks !=null && _userTasks.isNotEmpty
            ? ListView.builder(
          padding: EdgeInsets.only(top: 30, bottom: 30),
          itemCount: _userTasks.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
              padding: EdgeInsets.only(left: 25, right: 20, top: 20, bottom: 20),
              height: getheight(context)*0.1,
                decoration: BoxDecoration(
                  color: Colors.white, // No front color
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.3), // Adjust the opacity as needed
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(2, 2), // minimal drop shadow
                    ),
                  ],
                ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(_userTasks[index]['title'], style: TextStyle(color: Colors.red, fontSize: 24),), Text('Tap to open', style: TextStyle(color: Colors.black54),)],),
                  Row(children: [IconButton(onPressed: (){
                    updateDialog(_userTasks[index]);
                  }, icon: Icon(Icons.edit_note, color: Colors.red,size: 34,)),
                    IconButton(onPressed: (){
                      deleteTask(_userTasks[index].id);
                    }, icon: Icon(Icons.delete, color: Colors.red,size: 30,))],  ),
                ]
              )
            );

          },
        )  : Center(child: Text('No Tasks yet')),

      ),
    );

  }
  //Dialog Box for inserting task to Firebase.....
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
                     _getTasks();
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
