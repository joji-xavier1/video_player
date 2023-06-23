import 'dart:io';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:video_player_task/app/core/widgets/inputfield.dart';
import 'package:video_player_task/app/modules/signup/views/widgets/otp_screen.dart';

import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);
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
          // appBar: AppBar(
          //   title: const Text('SignupView'),
          //   centerTitle: true,
          // ),
          body: SingleChildScrollView(
            child: Obx(
              () => controller.showOtpScreen.value
                  ? Center(child: OTPVerificationScreen())
                  : Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.20,
                        ),
                        Form(
                            autovalidateMode: controller.buttonPress.value
                                ? AutovalidateMode.onUserInteraction
                                : AutovalidateMode.disabled,
                            key: controller.loginFormKey,
                            child: SizedBox(
                              // height: MediaQuery.of(context).size.height * 0.50,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                child: Container(
                                  margin: const EdgeInsets.all(20),
                                  child: Obx(
                                    () => Column(
                                      children: [
                                        controller.image.isNotEmpty
                                            ? GestureDetector(
                                                onTap: () {
                                                  controller.selectUserImage();
                                                },
                                                child: CircleAvatar(
                                                  backgroundImage: FileImage(
                                                      File(controller.image
                                                          .value)), // Display camera icon if image is null
                                                  radius: 40,
                                                  backgroundColor: Colors.white,
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  controller.selectUserImage();
                                                },
                                                child: CircleAvatar(
                                                  radius: 40,
                                                  backgroundColor:
                                                      Colors.grey.shade400,
                                                  child: const Center(
                                                    child: Icon(
                                                      Icons.camera_alt,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ),

                                        const SizedBox(
                                          height: 20,
                                        ),
                                        InputField(
                                            validator: (value) {
                                              return controller
                                                  .validateName(value!);
                                            },
                                            border: 10,
                                            isRequired: true,
                                            icon: const Icon(
                                              Icons.account_circle,
                                              size: 24,
                                              color: Color(0xff655F74),
                                            ),
                                            isHidden: false,
                                            // title: 'Phone No',
                                            hint: 'Name',
                                            controller:
                                                controller.userNameController,
                                            readOnly: false,
                                            keyboardType: TextInputType.text),
                                        // SizedBox(
                                        //   height: 10,
                                        // ),
                                        InputField(
                                            validator: (value) {
                                              return controller
                                                  .validateEmail(value!);
                                            },
                                            icon: const Icon(Icons.email),
                                            border: 10,
                                            isRequired: true,
                                            isHidden: false,
                                            hint: 'Email',
                                            controller:
                                                controller.emailController,
                                            readOnly: false,
                                            keyboardType: TextInputType.text),

                                        InputField(
                                            validator: (value) {
                                              return controller
                                                  .validatePhone(value!);
                                            },
                                            icon: const Icon(Icons.phone),
                                            border: 10,
                                            isRequired: true,
                                            isHidden: false,
                                            hint: 'Phone',
                                            controller:
                                                controller.phoneController,
                                            readOnly: false,
                                            keyboardType: TextInputType.phone),
                                        InputField(
                                            validator: (value) {
                                              return controller
                                                  .validateDob(value!);
                                            },
                                            icon: GestureDetector(
                                              onTap: () {
                                                controller.showDatePickerDialog(
                                                    context);
                                              },
                                              child: const Icon(
                                                  Icons.calendar_month),
                                            ),
                                            border: 10,
                                            isRequired: true,
                                            isHidden: false,
                                            hint: 'DOB',
                                            controller:
                                                controller.dobController,
                                            readOnly: true,
                                            keyboardType: TextInputType.text),

                                        const SizedBox(
                                          height: 15,
                                        ),
                                        Obx(() => controller.isLoading.value
                                            ? const CircularProgressIndicator()
                                            : ElevatedButton(
                                                onPressed: () {
                                                  controller
                                                      .checkSignIn(context);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                    shape: RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8.0),
                                                        side: const BorderSide(
                                                            color: Color(
                                                                0xff004169))),
                                                    backgroundColor:
                                                        const Color(0xff004169),
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 18,
                                                        vertical: 12),
                                                    textStyle: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.normal)),
                                                child: const Text('Sign Up'),
                                              )),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            )),
                      ],
                    ),
            ),
          ),
        ));
  }
}
