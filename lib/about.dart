import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class aboutScreen extends StatelessWidget {
  const aboutScreen({super.key});

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
              Icons.dashboard_customize_rounded,
              size: 100,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "About Page",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
                "This was devloped to enter your daily\n tasks about your information")
          ],
        ),
      ),
    );
  }
}
