import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_app/model/task_model.dart';
import 'package:to_do_app/model/user_model.dart';

class FirebaseUtils {
  static CollectionReference<Task> getTaskCollection(String uid) {
    return getUserCollection()
        .doc(uid)
        .collection(Task.nameCollection)
        .withConverter<Task>(
          fromFirestore: (snapshot, _) => Task.fromFireStore(snapshot.data()!),
          toFirestore: (task, _) => task.toFireStore(),
        );
  }

  static Future<void> addTaskToFireStore(Task task, String uid) async {
    var taskCollection = getTaskCollection(uid); // collection
    DocumentReference<Task> taskDoc = taskCollection.doc(); // document
    task.id = taskDoc.id; //set model "id"

    return await taskDoc.set(task);
  }

  static Future<void> editTask(
    String id,
    String title,
    String desc,
    String uid,
    DateTime datetime,
  ) async {
    var collection = FirebaseUtils.getTaskCollection(uid);
    Task task = Task(title: title, description: desc, dateTime: datetime);
    return await collection.doc(id).update({
      'title': task.title,
      'description': task.description,
      'dateTime': datetime.millisecondsSinceEpoch,
    });
  }

  static Future<void> editIsDone(String id, bool isDone, String uid) async {
    var collection = FirebaseUtils.getTaskCollection(uid);
    return await collection.doc(id).update({
      'isDone': isDone,
    });
  }

  static Future<void> deleteFormFireStore(String id, String uid) async {
    var collection = FirebaseUtils.getTaskCollection(uid);
    return await collection.doc(id).delete();
  }

  static CollectionReference<UserModel> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(UserModel.user)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, options) =>
              UserModel.fromFireStore(snapshot.data()!),
          toFirestore: (user, options) => user.toFirestore(),
        );
  }

  static Future<void> addUserFireStore(UserModel user) {
    return getUserCollection().doc(user.id).set(user);
  }

  static Future<UserModel?> readUserFromFirestore(String uid) async {
    var user = await getUserCollection().doc(uid).get();

    return user.data();
  }
}
