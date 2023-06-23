import 'package:cloud_firestore/cloud_firestore.dart';

Future<Map<String, dynamic>?> retrieveUserDetails(String userId) async {
  try {
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);

    final userSnapshot = await userRef.get();
    if (userSnapshot.exists) {
      return userSnapshot.data();
    } else {
      print('User details not found!');
    }
  } catch (e) {
    print('Error retrieving user details: $e');
  }

  return null;
}
