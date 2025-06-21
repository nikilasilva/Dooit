import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/firestore_service.dart';

class CategoryProvider extends ChangeNotifier {
  final FirestoreService _firestoreService = FirestoreService();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // This static list holds the default categories.
  final List<Map<String, dynamic>> _defaultCategories = [
    {'id': 'default_work', 'icon': Icons.work, 'label': 'Work'},
    {'id': 'default_personal', 'icon': Icons.person, 'label': 'Personal'},
    {
      'id': 'default_shopping',
      'icon': Icons.shopping_cart,
      'label': 'Shopping',
    },
    {'id': 'default_health', 'icon': Icons.monitor_heart, 'label': 'Health'},
    {'id': 'default_home', 'icon': Icons.home, 'label': 'Home'},
    {'id': 'default_family', 'icon': Icons.family_restroom, 'label': 'Family'},
  ];

  List<Map<String, dynamic>> _userCategories = [];
  bool _isLoading = false;
  String? _errorMessage;
  StreamSubscription? _categoryStreamSubscription;

  // Getters
  List<Map<String, dynamic>> get categories => [
    ..._defaultCategories,
    ..._userCategories,
  ];
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void updateUser() {
    final user = _auth.currentUser;
    _categoryStreamSubscription?.cancel(); // Cancel any previous subscription

    if (user != null) {
      _setLoading(true);
      _categoryStreamSubscription = _firestoreService
          .getUserCategories(user.uid)
          .listen(
            (userCategories) {
              _userCategories = userCategories;
              _setLoading(false); // Also notifies listeners
            },
            onError: (e) {
              _setError('Failed to load categories: $e');
              _setLoading(false);
            },
          );
    } else {
      // If user is logged out, clear their custom categories.
      _userCategories = [];
      notifyListeners();
    }
  }

  // Add a new category
  Future<bool> addCategory(String label) async {
    if (_auth.currentUser == null) {
      _setError('You must be logged in to add categories');
      return false;
    }

    _setLoading(true);
    _clearError();

    try {
      final userId = _auth.currentUser!.uid;

      // Choose a default icon or impelement icon selection
      await _firestoreService.addCategory(userId, label, 'category');
      return true;
    } catch (e) {
      _setError('Failed to add category: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Delete a category
  Future<bool> deleteCategory(String categoryId) async {
    if (_auth.currentUser == null) {
      _setError('You must be logged in to delete categories');
      return false;
    }

    _setLoading(true);
    _clearError();

    try {
      final userId = _auth.currentUser!.uid;
      await _firestoreService.deleteCategory(userId, categoryId);
      return true;
    } catch (e) {
      _setError('Failed to delete category: $e');
      return false;
    } finally {
      _setLoading(false);
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

  @override
  void dispose() {
    _categoryStreamSubscription?.cancel();
    super.dispose();
  }
}
