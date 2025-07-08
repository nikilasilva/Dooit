import 'dart:collection';

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

  // Get tasks due today
  List<Task> get tasksForToday {
    final now = DateTime.now();
    return _tasks.where((task) {
      if (task.dueDate == null) return false; // Prevent exception
      return task.dueDate!.year == now.year &&
          task.dueDate!.month == now.month &&
          task.dueDate!.day == now.day;
    }).toList();
  }

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

  // Delete completed previous tasks
  Future<void> deleteCompletedPreviousTasks() async {
    if (_auth.currentUser == null) {
      _setError("You must be logged into perform this action");
      return;
    }
    _setLoading(true);
    _clearError();

    try {
      final userId = _auth.currentUser!.uid;
      final now = DateTime.now();
      final startOfToday = DateTime(now.year, now.month, now.day);

      final tasksToDelete =
          _tasks.where((task) {
            return task.isCompleted &&
                task.dueDate != null &&
                task.dueDate!.isBefore(startOfToday);
          }).toList();

      if (tasksToDelete.isEmpty) {
        _setLoading(false);
        return;
      }

      final taskIdsToDelete = tasksToDelete.map((task) => task.id).toList();

      await _firestoreService.deleteBatchTasks(userId, taskIdsToDelete);
    } catch (e) {
      _setError("Failed to delete completed tasks: $e");
    } finally {
      _setLoading(false);
    }
  }

  // Getters for progress screen
  // Number of tasks completed today
  int get completedTasksToday {
    return tasksForToday.where((task) {
      return task.isCompleted;
    }).length;
  }

  // Total number of tasks scheduled for today
  int get totalTasksToday {
    return tasksForToday.length;
  }

  // Calculates the current completion streak
  int get completionStreak {
    // 1. Get all unique days where at least one task was completed
    // SplayTreeset automatically sorts the dates
    final completedDays = SplayTreeSet<DateTime>((a, b) => a.compareTo(b));

    for (var task in _tasks) {
      if (task.isCompleted && task.dueDate != null) {
        final day = DateTime(
          task.dueDate!.year,
          task.dueDate!.month,
          task.dueDate!.day,
        );
        completedDays.add(day);
      }
    }

    if (completedDays.isEmpty) return 0;

    // 2. Check if the streak is current (includes today or yesterday)
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(Duration(days: 1));

    if (!completedDays.contains(today) && !completedDays.contains(yesterday)) {
      return 0; // Streak is broken
    }

    // 3. Calculate the length of the current streak.
    int currentStreak = 0;
    DateTime expectedDay = today;

    for (final day in completedDays.toList().reversed) {
      if (day == expectedDay || (currentStreak == 0 && day == yesterday)) {
        currentStreak++;
        expectedDay = day.subtract(Duration(days: 1));
      } else if (day.isBefore(expectedDay)) {
        break;
      }
    }

    return currentStreak;
  }

  // get tasks count
  Map<String, int> get taskCountByCategory {
    final Map<String, int> counts = {};
    for (final task in _tasks) {
      final category = task.category;
      counts[category] = (counts[category] ?? 0) + 1;
    }
    return counts;
  }

  // In your TaskProvider class
  Map<DateTime, int> get completedTasksPerDay {
    final Map<DateTime, int> result = {};
    for (final task in _tasks) {
      if (task.isCompleted && task.dueDate != null) {
        // Normalize the date to remove time
        final date = DateTime(
          task.dueDate!.year,
          task.dueDate!.month,
          task.dueDate!.day,
        );
        result[date] = (result[date] ?? 0) + 1;
      }
    }
    return result;
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
