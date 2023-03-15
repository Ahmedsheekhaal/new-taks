import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:test/auth/SingInPage.dart';
import 'package:test/home.dart';

class SingUpScreen extends StatefulWidget {
  const SingUpScreen({super.key});

  @override
  State<SingUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SingUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController PasswordController = TextEditingController();
  TextEditingController fullnameController = TextEditingController();

  TextEditingController phoneController = new TextEditingController();
  final error = false.obs;
  final empty = false.obs;
  final loading = false.obs;

  void createUser() async {
    try {
      loading.value = true;
      final auth = FirebaseAuth.instance;
      final email = emailController.text;
      final password = PasswordController.text;

      if (email.isEmpty || password.isEmpty) {
        final snackdemo = SnackBar(
          content: Text('Please Fill The Missing.'),
          backgroundColor: Colors.red,
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(5),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackdemo);
        empty.value = true;
        loading.value = false;
      }

      if (email.isEmpty & password.isEmpty != empty) {
        final credential = FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: PasswordController.text,
        );
      }

      loading.value = false;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        final snackdemo = SnackBar(
          content: Text('The password provided is too weak'),
          backgroundColor: Colors.green,
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(5),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackdemo);
        loading.value = false;
        return;
      } else if (e.code == 'email-already-in-use') {
        final snackdemo = SnackBar(
          content: Text('The account already exists for that email.'),
          backgroundColor: Colors.green,
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(5),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackdemo);
        loading.value = false;
        return;
      } else if (e.code == 'The email address is badly formatted') {
        final snackdemo = SnackBar(
          content: Text('The email address is badly formatted.'),
          backgroundColor: Colors.green,
          elevation: 10,
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.all(5),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackdemo);
        loading.value = false;
        return;
      }
    } catch (e) {
      loading.value = false;
      final snackdemo = SnackBar(
        content: Text('please correct the input'),
        backgroundColor: Colors.red,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackdemo);
      return;
    }
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
            children: [
              const SizedBox(height: 89),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text("Singup Page",
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
                  controller: fullnameController,
                  decoration: InputDecoration(
                      hintText: "Full Name", prefixIcon: Icon(Icons.person)),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 47),
                child: TextField(
                  controller: emailController,
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
                  controller: PasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Password", prefixIcon: Icon(Icons.password)),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 23, vertical: 30),
                  child: Column(children: [
                    Obx(
                      () => MaterialButton(
                        onPressed: () {
                          createUser();
                        },
                        height: 55,
                        padding: EdgeInsets.all(10),
                        color: Colors.black,
                        child: loading.value == true
                            ? Center(
                                child: LoadingAnimationWidget.fourRotatingDots(
                                    color: Colors.white, size: 30),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    " Singup ",
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
                      height: 6,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                            onPressed: () {
                              Get.to(SingInScreen());
                            },
                            child: const Text(
                              "SingIn",
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
