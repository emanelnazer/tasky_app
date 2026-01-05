import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasky/core/network/result_firbase.dart';
import 'package:tasky/feature/home/data/model/task_dto.dart';


  class FireBaseTask {
  static CollectionReference<TaskDto> get _getCollection {
    final userToken = FirebaseAuth.instance.currentUser?.uid;
    if (userToken == null) throw Exception("User not logged in");

    return FirebaseFirestore.instance
        .collection(TaskDto.collection)
        .doc(userToken)
        .collection(TaskDto.collection)
        .withConverter<TaskDto>(
      fromFirestore: (snap, _) => TaskDto.fromJson(snap.data()!, snap.id),
      toFirestore: (task, _) => task.toJson(),
    );
  }

  Future<ResultFB<TaskDto>> addTask(TaskDto task) async {
    try {
      final doc = _getCollection.doc();
      task.id = doc.id;

      await doc.set(task); // Converter handle toJson

      return SucessFB(data: task);
    } catch (e) {
      return ErrorFB(e.toString());
    }
  }

    Future<ResultFB<List<TaskDto>>> getTask(DateTime date) async {
    final normaldate =
        DateTime(date.year, date.month, date.day).millisecondsSinceEpoch;
    try {
      var querySnapshot =
      await _getCollection.where('date', isEqualTo: normaldate).get();
      final listoftask =
      querySnapshot.docs.map<TaskDto>((doc) => doc.data()).toList();
      return SucessFB(data: listoftask);
    } catch (e) {
      return ErrorFB(e.toString());
    }
  }

   Future<ResultFB<TaskDto>> updateTask(TaskDto task) async {
    try {
      if (task.id == null) throw Exception("Task ID is null");

      final doc = _getCollection.doc(task.id);
      await doc.update(task.toJson());
      return SucessFB(data: task);
    } catch (e) {
      return ErrorFB(e.toString());
    }
  }
}
FireBaseTask injectHomeFirebase()=>FireBaseTask();