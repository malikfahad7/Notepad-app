import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {

  //Adding Tasks to Firebase....
  Future addTask(Map<String, dynamic>taskInfo, String id)async {
        return await FirebaseFirestore.instance.
        collection("Todo").doc(id).collection("tasks").add(taskInfo);
  }




}
    
    