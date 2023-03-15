import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import 'about.dart';
import 'auth/SingInPage.dart';

class settingScreen extends StatefulWidget {
  const settingScreen({super.key});

  @override
  State<settingScreen> createState() => _settingScreenState();
}

class _settingScreenState extends State<settingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("About Page"),
      ),
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.settings,
              size: 100,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Settings Page",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8,
            ),
            Text("Change your siitengs here."),
            Divider(
              thickness: 0,
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('About'),
              onTap: () {
                Get.to(aboutScreen());
              },
            ),
            Container(
              color: Colors.grey.shade200,
              child: ListTile(
                leading: const Icon(Icons.book),
                title: const Text('Settings'),
                onTap: () {
                  Get.off(settingScreen());
                },
              ),
            ),
            ListTile(
              leading: const Icon(Icons.workspace_premium),
              title: const Text('Back to Home'),
              onTap: () {
                Get.back();
              },
            ),
            Container(
              color: Colors.grey.shade200,
              child: ListTile(
                leading: const Icon(Icons.logout),
                title: const Text('LogOut'),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                  Get.offAll(SingInScreen());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
