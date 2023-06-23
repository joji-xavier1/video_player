import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';

import 'package:get/get.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
    if (Platform.isAndroid) {
      FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
    }
  });
  // Initialize Firebase app
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: FirebaseAuthService().isUserLoggedIn ? '/home' : '/login',
      getPages: AppPages.routes,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light, // Set the initial theme mode
    );
  }
}

class FirebaseAuthService {
  bool get isUserLoggedIn {
    // Your logic to check if the user is logged in with Firebase Authentication
    // Return true if the user is logged in, false otherwise
    return checkUserLoggedIn();
  }
}

bool checkUserLoggedIn() {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user = auth.currentUser;

  if (user != null) {
    // User is logged in
    return true;
  } else {
    return false;
  }
}
