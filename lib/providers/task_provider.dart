import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/task.dart';
import '../services/firestore_service.dart';

class TaskProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  List<Task> _tasks = [];
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  List<Task> get tasks => _tasks;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<bool> addTask({
    required String title,
    required String category,
    required String time,
    required DateTime date,
    String note = '',
  }) async {
    if (_auth.currentUser == null) {
      _errorMessage = 'You must be logged in to add tasks';
      notifyListeners();
      return false;
    }

    _setLoading(true);
    _clearError();

    try {
      final userId = _auth.currentUser!.uid;

      final newTask = Task(
        id: '', // Firestore will generate this
        title: title,
        note: note,
        category: category,
        time: time,
        isCompleted: false,
        createdAt: DateTime.now(),
        dueDate: date,
      );

      await _firestoreService.addTask(userId, newTask);
      notifyListeners();
      return true;
    } catch (e) {
      _setError('Failed to add task: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Load tasks
  Future<void> loadTasks() async {
    if (_auth.currentUser == null) return;

    _setLoading(true);
    _clearError();

    try {
      final userId = _auth.currentUser!.uid;
      _firestoreService.getTasks(userId).listen((tasks) {
        _tasks = tasks;
        notifyListeners();
      });
    } catch (e) {
      _setError('Failed to load tasks: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Toggle task completion
  Future<void> toggleTaskCompletion(Task task) async {
    if (_auth.currentUser == null) return;

    try {
      final userId = _auth.currentUser!.uid;
      await _firestoreService.toggleTaskCompletion(userId, task);
    } catch (e) {
      _setError('Failed to update task: $e');
    }
  }

  // Delete task
  Future<void> deleteTask(String taskId) async {
    if (_auth.currentUser == null) return;

    try {
      final userId = _auth.currentUser!.uid;
      await _firestoreService.deleteTask(userId, taskId);
    } catch (e) {
      _setError('Failed to delete task: $e');
    }
  }

  // Helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}
