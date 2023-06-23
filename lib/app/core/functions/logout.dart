import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

void logout() async {
  try {
    await FirebaseAuth.instance.signOut();
    Get.offAndToNamed('/login');
  } catch (e) {
    print('Error logging out: $e');
  }
}
