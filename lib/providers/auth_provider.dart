import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null;

  AuthProvider() {
    // Listen to auth state changes
    _authService.authStateChanges.listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  // Sign up method
  Future<bool> signUp(String email, String password, String username) async {
    try {
      _setLoading(true);
      _clearError();

      UserCredential? result = await _authService.signUpWithEmailAndPassword(
        email,
        password,
      );

      if (result != null && result.user != null) {
        // Update display name if provided
        if (username.isNotEmpty) {
          await result.user!.updateDisplayName(username);
          await result.user!.reload();
        }

        _user = _authService.currentUser;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Sign in method
  Future<bool> signIn(String email, String password) async {
    try {
      _setLoading(true);
      _clearError();

      UserCredential? result = await _authService.signInWithEmailAndPassword(
        email,
        password,
      );

      if (result != null && result.user != null) {
        _user = result.user;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Sign out method
  Future<void> signOut() async {
    try {
      _setLoading(true);
      await _authService.signOut();
      _user = null;
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // Reset password
  Future<bool> resetPassword(String email) async {
    try {
      _setLoading(true);
      _clearError();

      await _authService.resetPassword(email);
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    if (_user == null || _user!.email == null) {
      _setError("No user is currently signed in.");
      return false;
    }

    _setLoading(true);
    _clearError();

    try {
      // Create credentials with the user's email and old password
      AuthCredential credential = EmailAuthProvider.credential(email: _user!.email!, password: oldPassword);

      // Re-authencticate the user to confirm their identity
      await _user!.reauthenticateWithCredential(credential);

      // if re_authenctication is successful, update the password.
      await _user!.updatePassword(newPassword);

      return true;

    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        _setError('The old password you entered is incorrect.');
      } else if (e.code == 'weak-password') {
        _setError('The new password is too weak');
      } else {
        _setError("An error occured. Please try again.");
      }
      return false;
    } catch (e) {
      _setError("An unexpected error occured: ${e.toString()}");
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // Update username
  Future<bool> updateUsername(String newUsername) async {
    if (_user == null) {
      _setError("No user is currently signed in.");
      return false;
    }
    if (newUsername.trim().isEmpty) {
      _setError("Username cannot be empty");
      return false;
    }

    _setLoading(true);
    _clearError();

    try {
      await _user!.updateDisplayName(newUsername);
      // Reload the user object to get updated info
      await _user!.reload();
      _user = _authService.currentUser;
      return true;
    } catch (e) {
      _setError("Failed to update username: ${e.toString()}");
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

  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearError() {
    _clearError();
  }
}
