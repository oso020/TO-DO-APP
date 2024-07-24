import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/model/task_model.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTaskCollection() {
    return FirebaseFirestore.instance
        .collection(Task.nameCollection)
        .withConverter<Task>(
          fromFirestore: (snapshot, _) => Task.fromFireStore(snapshot.data()!),
          toFirestore: (task, _) => task.toFireStore(),
        );
  }

  static Future<void> addTaskToFireStore(Task task) {
    var taskCollection = getTaskCollection(); // collection
    DocumentReference<Task> taskDoc = taskCollection.doc();
    task.id = taskDoc.id;

    return taskDoc.set(task);
  }
}
