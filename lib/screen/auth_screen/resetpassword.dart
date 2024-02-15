import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../model/FirebaseAuth.dart';
class Changepassword extends StatefulWidget {
  const Changepassword({Key? key}) : super(key: key);

  @override
  State<Changepassword> createState() => _ChangepasswordState();
}

class _ChangepasswordState extends State<Changepassword> {

  var emailcon=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(decoration: InputDecoration(label: Text("Enter email"),border: OutlineInputBorder()),controller:emailcon,),
        ),


        ElevatedButton(onPressed:(){
          forgetpasss(emailcon.text.toString());
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:Text("Check your email for password reset")));
          Navigator.pop(context);
          },      style: ElevatedButton.styleFrom(
            fixedSize: const Size(200, 50),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(70))),
          child: const Text('Reset Password'),)
      ],
    ),);
  }
}
