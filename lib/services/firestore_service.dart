import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/task.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Get user-specific tasks collection
  CollectionReference _getUserTasksCollection(String userId) {
    return _db.collection('users').doc(userId).collection('tasks');
  }

  // Get user-specific categories collection
  CollectionReference _getUserCategoriesCollection(String userId) {
    return _db.collection('users').doc(userId).collection('categories');
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

  Future<void> deleteBatchTasks(String userId, List<String> taskIds) async {
    final batch = _db.batch();
    final tasksCollection = _getUserTasksCollection(userId);
    for (final taskId in taskIds) {
      batch.delete(tasksCollection.doc(taskId));
    }

    await batch.commit();
  }

  Stream<List<Map<String, dynamic>>> getUserCategories(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('categories')
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data();
            return {
              'id': doc.id,
              'icon': _getIconFromString(data['icon'] ?? 'category'),
              'label': data['label'] ?? 'Category',
            };
          }).toList();
        });
  }

  // Add a new category
  Future<void> addCategory(String userId, String label, String iconName) async {
    await _getUserCategoriesCollection(
      userId,
    ).add({'label': label, 'icon': iconName, 'createdAt': Timestamp.now()});
  }

  // Delete a category
  Future<void> deleteCategory(String userId, String categoryId) async {
    await _getUserCategoriesCollection(userId).doc(categoryId).delete();
  }

  // Helper method to convert string icon name to IconData
  IconData _getIconFromString(String iconName) {
    switch (iconName) {
      case 'work':
        return Icons.work;
      case 'person':
        return Icons.person;
      case 'shopping_cart':
        return Icons.shopping_cart;
      case 'monitor_heart':
        return Icons.monitor_heart;
      case 'home':
        return Icons.home;
      case 'family_restroom':
        return Icons.family_restroom;
      case 'school':
        return Icons.school;
      case 'fitness_center':
        return Icons.fitness_center;
      case 'local_dining':
        return Icons.local_dining;
      case 'celebration':
        return Icons.celebration;
      default:
        return Icons.category;
    }
  }
}
