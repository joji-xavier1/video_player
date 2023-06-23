import 'package:cloud_firestore/cloud_firestore.dart';

void saveUserDetails(
    {required String userId,
    required String name,
    required String email,
    required String dob,
    required String imageUrl}) async {
  try {
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);

    await userRef.set({
      'name': name,
      'email': email,
      'imageUrl': imageUrl,
      'dob': dob,
    });

    print('User details saved successfully!');
  } catch (e) {
    print('Error saving user details: $e');
  }
}
