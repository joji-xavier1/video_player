import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:video_player_task/app/core/widgets/inputfield.dart';
import 'package:video_player_task/app/core/widgets/otp_screen.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final homeController = Get.put(LoginController());

  LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              end: Alignment.center,
              begin: Alignment.bottomCenter,
              colors: [
            Color.fromARGB(255, 11, 86, 9),
            Color(0xfffafafa),
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          reverse: true,
          child: Obx(
            () => controller.showOtpScreen.value
                ? const OtpScreen()
                : Container(
                    margin: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.18,
                        ),
                        const Text(
                          'Welcome',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 85,
                        ),
                        Form(
                          autovalidateMode: controller.buttonPress.value
                              ? AutovalidateMode.onUserInteraction
                              : AutovalidateMode.disabled,
                          key: controller.loginFormKey,
                          child: SizedBox(
                            width: 376,
                            height: MediaQuery.of(context).size.height * 0.40,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: Container(
                                margin: const EdgeInsets.all(20),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    InputField(
                                        validator: (value) {
                                          return controller
                                              .validatePhone(value!);
                                        },
                                        border: 10,
                                        isRequired: true,
                                        icon: const Icon(
                                          Icons.phone,
                                          size: 24,
                                          color: Color(0xff655F74),
                                        ),
                                        isHidden: false,
                                        hint: 'Phone No',
                                        controller: controller.phoneController,
                                        readOnly: false,
                                        keyboardType: TextInputType.phone),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Obx(() => controller.isLoading.value
                                        ? const CircularProgressIndicator()
                                        : ElevatedButton(
                                            onPressed: () {
                                              controller.checkLogin(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                    side: const BorderSide(
                                                        color:
                                                            Color(0xff004169))),
                                                backgroundColor:
                                                    const Color(0xff004169),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 18,
                                                        vertical: 12),
                                                textStyle: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.normal)),
                                            child: const Text('Login'),
                                          )),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Get.offAndToNamed('/signup');
                                        },
                                        child: const Text(
                                          "Don't have an account? Sigin Up",
                                          style: TextStyle(
                                              color: Color(0xff004169),
                                              fontSize: 15),
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
