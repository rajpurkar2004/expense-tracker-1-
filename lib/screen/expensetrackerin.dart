import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("About Us"),),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Expense tracker is an app that helps you to track expenses"
            "this app helps you to track daily expenses"
            "If you have quires email us at abid@gmail.com"
            "")
      ],
    ),
    );
  }
}
