import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/task.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get user-specific tasks collection
  CollectionReference _getUserTasksCollection(String userId) {
    return _db.collection('users').doc(userId).collection('tasks');
  }

  // Add Task for specific user
  Future<void> addTask(String userId, Task task) async {
    await _getUserTasksCollection(userId).add(task.toFirestore());
  }

  // Fetch tasks for specific user
  Stream<List<Task>> getTasks(String userId) {
    return _getUserTasksCollection(userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Task.fromFireStore(doc)).toList(),
        );
  }

  // Update Task (Mark as Completed/Incomplete)
  Future<void> updateTask(
    String userId,
    String taskId,
    Map<String, dynamic> updates,
  ) async {
    await _getUserTasksCollection(userId).doc(taskId).update(updates);
  }

  // Toggle task completion
  Future<void> toggleTaskCompletion(String userId, Task task) async {
    await _getUserTasksCollection(
      userId,
    ).doc(task.id).update({'isCompleted': !task.isCompleted});
  }

  // Delete Task
  Future<void> deleteTask(String userId, String taskId) async {
    await _getUserTasksCollection(userId).doc(taskId).delete();
  }

  // Get tasks by category
  Stream<List<Task>> getTasksByCategory(String userId, String category) {
    return _getUserTasksCollection(userId)
        .where('category', isEqualTo: category)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Task.fromFireStore(doc)).toList(),
        );
  }

  // Get completed tasks
  Stream<List<Task>> getCompletedTasks(String userId) {
    return _getUserTasksCollection(userId)
        .where('isCompleted', isEqualTo: true)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Task.fromFireStore(doc)).toList(),
        );
  }

  // Get pending tasks
  Stream<List<Task>> getPendingTasks(String userId) {
    return _getUserTasksCollection(userId)
        .where('isCompleted', isEqualTo: false)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Task.fromFireStore(doc)).toList(),
        );
  }
}
