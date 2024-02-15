import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../data/user.dart';
import '../../model/user.dart';

class UsersInfos extends StatefulWidget {
  const UsersInfos({Key? key}) : super(key: key);

  @override
  State<UsersInfos> createState() => _UsersInfosState();
}

class _UsersInfosState extends State<UsersInfos> {
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var genderController=TextEditingController();
  var ageController=TextEditingController();
  var phoneNumberController=TextEditingController();
  @override

  void initState() {
     FirebaseFirestore.instance.collection("User").doc(FirebaseAuth.instance.currentUser!.uid).get().then(
          (DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        nameController.text=data["user name"];
            emailController.text=data["email"];
            ageController.text=data["age"];
            phoneNumberController.text=data["phoneNumber"];

          },
      onError: (e) => print("Error getting document: $e"),
    );


    super.initState();
  }
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("User Info"),),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(decoration: InputDecoration(label: Text("Enter Name"),border: OutlineInputBorder()),controller:nameController,),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(decoration: InputDecoration(label: Text("Enter email"),border: OutlineInputBorder()),controller:emailController,),
        ),


        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(decoration: InputDecoration(label: Text("Enter age"),border: OutlineInputBorder()),controller:ageController,),
        ),



        

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(decoration: InputDecoration(label: Text("Enter phone number"),border: OutlineInputBorder()),controller:phoneNumberController,),
        ),


        ElevatedButton(onPressed: (){

          CurrentUser user=CurrentUser(name:nameController.text ,age:ageController.text ,email:emailController.text,phoneNumber:int.parse( phoneNumberController.text),gender: "Male");

          Provider.of<MyUser>(context, listen: false).changeUser(user);
          FirebaseFirestore.instance.collection("User").doc(FirebaseAuth.instance.currentUser!.uid).update(
              {
                "user name":nameController.text,
                "email":emailController.text,
                "phoneNumber":phoneNumberController.text,
                "age":ageController.text,

              }).whenComplete(() => Navigator.pop(context));

        }, child: Text("Update Profile"))


      ],)
      ,);
  }
}
