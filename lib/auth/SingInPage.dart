import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:test/auth/SingUpPage.dart';
import 'package:test/home.dart';

class SingInScreen extends StatefulWidget {
  const SingInScreen({super.key});

  @override
  State<SingInScreen> createState() => _SingInScreenState();
}

class _SingInScreenState extends State<SingInScreen> {
  TextEditingController emailcontroller = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  final error = false.obs;
  final empty = false.obs;
  final loading = false.obs;
  var displayUserName = ''.obs;
  var displayUserPhoto = ''.obs;
  var displayUserEmail = ''.obs;
  Future signin() async {
    loading.value = true;
    final auth = FirebaseAuth.instance;
    final email = emailcontroller.text;

    final password = passwordController.text;
    if (email.isEmpty || password.isEmpty) {
      final snackdemo = SnackBar(
        content: Text('Please Fill The Missing.'),
        backgroundColor: Colors.red,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackdemo);
      loading.value = false;
      return;
    }
    try {
      auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        Get.offAll(HomePage());
      }).catchError((onError) {
        final snackdemo = SnackBar(
          content: Text('Invalid Email Or Password.'),
          backgroundColor: Colors.red,
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(5),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackdemo);
      });
      loading.value = false;
    } on FirebaseAuthException catch (e) {
      e.message;
      loading.value = false;
    }
  }

  void showMessage(String message) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text(message),
            actions: [
              TextButton(
                child: Text("Ok"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Container(
          height: screenheight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 109),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Login Page",
                      style: TextStyle(
                          fontSize: 32,
                          fontFamily: "Mulish",
                          fontWeight: FontWeight.w800)),
                ],
              ),
              const SizedBox(
                height: 34,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 47),
                child: TextField(
                  controller: emailcontroller,
                  decoration: InputDecoration(
                      hintText: "Email", prefixIcon: Icon(Icons.email)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 47),
                child: TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Password", prefixIcon: Icon(Icons.password)),
                ),
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 23, vertical: 30),
                  child: Column(children: [
                    Obx(
                      () => MaterialButton(
                        onPressed: () {
                          signin();
                        },
                        height: 55,
                        padding: EdgeInsets.all(10),
                        color: Colors.black,
                        child: loading.isTrue
                            ? Center(
                                child: LoadingAnimationWidget.fourRotatingDots(
                                    color: Colors.white, size: 30),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    " Login ",
                                    style: TextStyle(
                                        fontSize: 22, color: Colors.white),
                                  )
                                ],
                              ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              Get.to(SingUpScreen());
                            },
                            child: const Text(
                              "SingUp",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  ])),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
