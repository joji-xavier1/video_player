import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player_task/app/modules/signup/controllers/signup_controller.dart';

class OTPVerificationScreen extends StatefulWidget {
  final signupController = Get.put<SignupController>(SignupController());
  OTPVerificationScreen({super.key});

  @override
  OTPVerificationScreenState createState() => OTPVerificationScreenState();
}

class OTPVerificationScreenState extends State<OTPVerificationScreen> {
  late Timer _timer;
  int _countDown = 120;
  final List<TextEditingController> _otpControllers = [];
  final List<FocusNode> _focusNodes = [];

  @override
  void initState() {
    super.initState();
    startTimer();
    initializeOTPControllers();
  }

  void initializeOTPControllers() {
    for (int i = 0; i < 6; i++) {
      TextEditingController controller = TextEditingController();
      FocusNode focusNode = FocusNode();
      _otpControllers.add(controller);
      _focusNodes.add(focusNode);
      if (i < 5) {
        controller.addListener(() {
          if (controller.text.isNotEmpty) {
            _focusNodes[i + 1].requestFocus();
          }
        });
      }
    }
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      setState(() {
        if (_countDown < 1) {
          timer.cancel();
        } else {
          _countDown -= 1;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  void resend() {
    widget.signupController.resendOTP();
    setState(() {
      _countDown = 120;
      startTimer();
    });
  }

  void verifyOTP() async {
    String otp = '';
    for (var controller in _otpControllers) {
      otp += controller.text;
    }
    final result = await widget.signupController.verifyOtp(otp);
    if (result) {
      Get.offAndToNamed('/home');
    }
    print('Verifying OTP: $otp');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.3,
          ),
          const Text(
            'Enter OTP:',
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 16),
          // OTP input fields
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              6,
              (index) => SizedBox(
                width: 40,
                child: TextField(
                  controller: _otpControllers[index],
                  focusNode: _focusNodes[index],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 1,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      if (index < 5) {
                        _focusNodes[index + 1].requestFocus();
                      } else {
                        // If last digit, trigger OTP verification
                        verifyOTP();
                      }
                    }
                  },
                  decoration: const InputDecoration(
                    counterText: '',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Timer for OTP resend
          Text(
            'Resend OTP in $_countDown seconds',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          // Resend OTP button
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    side: const BorderSide(color: Color(0xff004169))),
                backgroundColor: const Color(0xff004169),
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
                textStyle: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.normal)),
            onPressed: (_countDown == 0) ? resend : null,
            child: const Text('Resend OTP'),
          ),
        ],
      )),
    );
  }
}
