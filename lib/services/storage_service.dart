import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Upload a profile picture and return the download URL
  Future<String?> uploadProfilePicture(String userId, File imageFile) async {
    try {
      final ref = _storage.ref('profile_pictures/$userId.jpg');

      final uploadTask = ref.putFile(imageFile);

      // await the upload to complete
      final snapshot = await uploadTask.whenComplete(() => {});

      // Get the download URL
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error uploading profile picture: $e");
      return null;
    }
  }
}
