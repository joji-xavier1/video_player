import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final buttonPress = false.obs;
  final showOtpScreen = false.obs;
  String? token;

  final isPasswordVisible = true.obs;
  final isLoading = false.obs;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  var verificationId = ''.obs;
  @override
  void onClose() {}
  void checkLogin(BuildContext context) async {
    isLoading.value = true;
    buttonPress.value = true;
    update();
    final isValid = loginFormKey.currentState!.validate();
    if (!isValid) {
      isLoading.value = false;

      return;
    }
    loginFormKey.currentState!.save();
    phoneAuthentication(phoneController.text.trim());
  }

  void phoneAuthentication(String phone) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: '+91$phone',
      verificationCompleted: (phoneAuthCredential) async {
        final result = await _auth.signInWithCredential(phoneAuthCredential);
        if (result.user != null) {
          Get.offAndToNamed('/home');
        }
      },
      verificationFailed: (error) {
        isLoading.value = false;
        if (error.code == 'invalid-phone-number') {
          Get.snackbar('Error', 'The provided phone number is not valid.',
              colorText: Colors.red);
        } else {
          Get.snackbar('Error', 'Something get wrong', colorText: Colors.red);
        }
      },
      codeSent: (verificationId, forceResendingToken) {
        this.verificationId.value = verificationId;
        showOtpScreen.value = true;
      },
      timeout: const Duration(minutes: 2),
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
      },
    );
  }

  void passwordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  String? validatePhone(String value) {
    if (value.length < 10) {
      return 'Provide Valid Phone Number';
    }
    return null;
  }
}
