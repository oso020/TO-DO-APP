import 'package:flutter/cupertino.dart';

import '../firebase_utils.dart';
import '../model/task_model.dart';

class GetTaskProvider extends ChangeNotifier {
  List<Task> tasks = [];
  DateTime selectDate = DateTime.now();
  bool isDone = false;

  void getTaskFromFireStore(String uid) async {
    var collection = await FirebaseUtils.getTaskCollection(uid).get();
    tasks = collection.docs.map((task) {
      return task.data();
    }).toList();

    tasks = tasks.where((task) {
      if (task.dateTime.day == selectDate.day &&
          task.dateTime.month == selectDate.month &&
          task.dateTime.year == selectDate.year) {
        return true;
      }
      return false;
    }).toList();

    tasks.sort((Task task1, Task task2) {
      return task1.dateTime.compareTo(task2.dateTime);
    });

    notifyListeners();
  }

  void changeSelectDate(DateTime newDateTime, String uid) {
    selectDate = newDateTime;
    getTaskFromFireStore(uid);
  }

  Future<void> editTask(String id, String title, String desc, String uid,
      DateTime datetime) {
    return FirebaseUtils.editTask(id, title, desc, uid, datetime);
  }

  Future<void> doneTask(String id
      , String uid) async {
    return await FirebaseUtils.editIsDone(id, isDone, uid);
  }

  Future<void> deleteFromFireStore(String id, String uid) async {
    return await FirebaseUtils.deleteFormFireStore(id, uid);
  }
}
