import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test/auth/SingInPage.dart';
import 'home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  RxBool isAdmin = false.obs;

  @override
  void initState() {
    super.initState();
    final auth = FirebaseAuth.instance;

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (auth.currentUser == null) {
        Timer(Duration(seconds: 5), () => Get.offAll(SingInScreen()));
      } else {
        Timer(Duration(seconds: 4), () => Get.offAll(HomePage()));
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.task,
              size: 140,
            )
            // Lottie.asset("assets/lottie.json"),
          ],
        ),
      ),
    );
  }
}
