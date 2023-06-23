import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

Future<String?> saveUserImage(
    {required String userId, required String imagePath}) async {
  try {
    final storageRef =
        FirebaseStorage.instance.ref().child('users/$userId/profile_image.jpg');
    final uploadTask = storageRef.putFile(File(imagePath));

    final TaskSnapshot uploadSnapshot = await uploadTask;
    final downloadUrl = await uploadSnapshot.ref.getDownloadURL();

    print('User image saved successfully!');
    return downloadUrl;
  } catch (e) {
    print('Error saving user image: $e');
    return null;
  }
}
