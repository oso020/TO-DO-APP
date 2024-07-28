import 'package:flutter/cupertino.dart';

import '../firebase_utils.dart';
import '../model/task_model.dart';

class GetTaskProvider extends ChangeNotifier {
  List<Task> tasks = [];
  DateTime selectDate = DateTime.now();
  bool isDone = false;

  void getTaskFromFireStore() async {
    var collection = await FirebaseUtils.getTaskCollection().get();
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

  void changeSelectDate(DateTime newDateTime) {
    selectDate = newDateTime;
    getTaskFromFireStore();
  }

  Future<void> editTask(
      String id, String title, String desc, DateTime datetime) {
    return FirebaseUtils.editTask(id, title, desc, datetime);
  }

  Future<void> doneTask(
    String id,
  ) {
    return FirebaseUtils.editIsDone(id, isDone);
  }

  Future<void> deleteFromFireStore(String id) {
    return FirebaseUtils.deleteFormFireStore(id);
  }
}
