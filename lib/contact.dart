import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class contactScreen extends StatelessWidget {
  const contactScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text("Contac Page"),
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
              "Daily Tasks",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8,
            ),
            Text("Application for you to use"),
            SizedBox(
              height: 20,
            ),
            Text("Gmail: dailyApp@gmail.com"),
            Text("PhoneNumber: +252634743232"),
            Text("Website: +dailyapp.com"),
          ],
        ),
      ),
    );
  }
}
