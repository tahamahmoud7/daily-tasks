import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_2/models/tasks.dart';

CollectionReference<TaskData> getTaskCollection() {
  return FirebaseFirestore.instance.collection("Tasks").withConverter(
      fromFirestore: (snapshot, options) => TaskData.fromJson(snapshot.data()!),
      toFirestore: (Task, options) => Task.toJson());
}

Future<void> addTaskToFirebaseFirestore(TaskData taskData) {
  var collection = getTaskCollection();
  var docRef = collection.doc();
  taskData.id = docRef.id;
  return docRef.set(taskData);
}

   Stream<QuerySnapshot<TaskData>> getTasksFromFirestore(DateTime dateTime) {
  return getTaskCollection()
      .where("date",
          isEqualTo: DateUtils.dateOnly(dateTime).millisecondsSinceEpoch)
      .snapshots();
}
Future<void> deleteTaskFromFirestore(String id){
return  getTaskCollection().doc(id).delete();
}

Future<void> editisDoneinFirestore(TaskData task){

  return  getTaskCollection().doc(task.id).update({
 "isDone":!task.isDone,
  });
}
Future<void>editTaskinFirebase(TaskData task){
  return getTaskCollection().doc(task.id).update(task.toJson());
}

