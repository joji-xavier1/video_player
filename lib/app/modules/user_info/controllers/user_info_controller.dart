import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:video_player_task/app/core/functions/get_user_details.dart';
import 'package:video_player_task/app/modules/user_info/model/user_info_model.dart';

class UserInfoController extends GetxController {
  //TODO: Implement UserInfoController

  final count = 0.obs;
  final isLoading = false.obs;
  Future<UserInfoModel?> getUserData() async {
    isLoading.value = true;
    User? currentUser = FirebaseAuth.instance.currentUser;
    String userID = currentUser!.uid;
    final userInfo = await retrieveUserDetails(userID);
    if (userInfo != null) {
      isLoading.value = false;
      return userInfoModelFromJson(jsonEncode(userInfo));
    }
    return null;
  }

  void increment() => count.value++;
}
