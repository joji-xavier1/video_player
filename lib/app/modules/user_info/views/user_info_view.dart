import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:video_player_task/app/modules/user_info/model/user_info_model.dart';

import '../controllers/user_info_controller.dart';

class UserInfoView extends GetView<UserInfoController> {
  const UserInfoView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(() => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : FutureBuilder<UserInfoModel?>(
                future: controller.getUserData(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    // if (snapshot.connectionState == ConnectionState.waiting) {
                    //   return Center(child: const CircularProgressIndicator());
                    // }
                    return Center(
                        child: Container(
                      margin: const EdgeInsets.all(20),
                      height: 500,
                      width: MediaQuery.of(context).size.width,
                      child: Material(
                        elevation: 10,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CircleAvatar(
                                radius: 50,
                                backgroundImage:
                                    NetworkImage(snapshot.data!.imageUrl!),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'User name :',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    snapshot.data!.name!,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Email :',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    snapshot.data!.email!,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'DOB :',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                  Text(
                                    snapshot.data!.dob!,
                                    style: const TextStyle(fontSize: 18),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ));
                  } else {
                    return const Center(
                      child: Text('No Data Found'),
                    );
                  }
                },
              )));
  }
}
