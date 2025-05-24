import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add Task
  Future<void> addTask(String title, String description) async {
    await _db.collection('tasks').add({
      'title': title,
      'description': description,
      'isCompleted': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Fetch Tasks
  Stream<List<Map<String, dynamic>>> getTasks() {
    return _db.collection('tasks').orderBy('createdAt', descending: true).snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => doc.data()).toList());
  }

  // Update Task (Mark as Completed)
  Future<void> updateTask(String docId, bool isCompleted) async {
    await _db.collection('tasks').doc(docId).update({'isCompleted': isCompleted});
  }

  // Delete Task
  Future<void> deleteTask(String docId) async {
    await _db.collection('tasks').doc(docId).delete();
  }
}
