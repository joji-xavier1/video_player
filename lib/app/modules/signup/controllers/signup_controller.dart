import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player_task/app/core/functions/save_data.dart';
import 'package:video_player_task/app/core/functions/save_image.dart';
import 'package:video_player_task/app/core/storage.dart';

class SignupController extends GetxController {
  //TODO: Implement SignupController
  final buttonPress = false.obs;
  final count = 0.obs;
  final isLoading = false.obs;
  final showOtpScreen = false.obs;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final dobController = TextEditingController();
  final ImagePicker picker = ImagePicker();
  final image = ''.obs;
  final _auth = FirebaseAuth.instance;
  var verificationId = ''.obs;

  void checkSignIn(BuildContext context) async {
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

  Future<String?> showDatePickerDialog(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      final formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate);
      print('Selected date: $formattedDate');
      dobController.text = formattedDate;
      return formattedDate;
    }

    return null;
  }

  String? validateEmail(String value) {
    if (!value.isEmail) {
      return 'Provide Valid Email id';
    }
    return null;
  }

  void resendOTP() async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId.value,
        smsCode: '',
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      print('OTP Resent successfully!');
    } catch (e) {
      print('Error resending OTP: $e');
    }
  }

  String? validatePhone(String value) {
    if (value.length < 10) {
      return 'Provide Valid Phone Number';
    }
    return null;
  }

  String? validateName(String value) {
    if (value.isEmpty) {
      return 'Provide Valid User Name';
    }
    return null;
  }

  String? validateDob(String value) {
    if (value.isEmpty) {
      return 'Provide Valid DOB';
    }
    return null;
  }

  void increment() => count.value++;

  void selectUserImage() async {
// Pick an image.
    final result = await picker.pickImage(source: ImageSource.gallery);
    if (result != null) {
      image.value = result.path;
    }
  }

  void phoneAuthentication(String phone) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: '+91$phone',
      verificationCompleted: (phoneAuthCredential) async {
        final result = await _auth.signInWithCredential(phoneAuthCredential);
        if (result.user != null) {
          // Saving user details and image
          String? imageUrl = await saveUserImage(
              userId: result.user!.uid, imagePath: image.value);
          if (imageUrl != null) {
            await saveString('imageUrl', imageUrl);
            saveUserDetails(
                userId: result.user!.uid,
                name: userNameController.text.trim(),
                email: emailController.text.trim(),
                imageUrl: imageUrl,
                dob: dobController.text.trim());
          }
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

  Future<bool> verifyOtp(String otp) async {
    final result = await _auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId.value, smsCode: otp));
    String? imageUrl =
        await saveUserImage(userId: result.user!.uid, imagePath: image.value);
    if (imageUrl != null) {
      saveUserDetails(
          userId: result.user!.uid,
          name: userNameController.text.trim(),
          email: emailController.text.trim(),
          imageUrl: imageUrl,
          dob: dobController.text.trim());
    }
    return result.user != null ? true : false;
  }
}
