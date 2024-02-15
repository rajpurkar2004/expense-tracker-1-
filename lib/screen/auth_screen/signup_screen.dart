
/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../../model/FirebaseAuth.dart';

class SignUpScreen extends StatefulWidget {

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var passController=TextEditingController();
  /*File? docuFile;
  String docUrl='';
  pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        docuFile = File(result.files.single.path.toString());
      });
    } else {
      // User canceled the picker
    }
    return result;
  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign up"),),
      body: ListView(

        children: [


          SizedBox(height: 80,),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Center(child: Text("Expense tracker",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),)),
          ),

          Card(
            elevation: 20,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
            margin: EdgeInsets.all(10),

            child: Column(children: [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(decoration: InputDecoration(label: Text("Enter name"),border: OutlineInputBorder()),controller:nameController,),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(decoration: InputDecoration(label: Text("Enter email"),border: OutlineInputBorder()),controller:emailController,),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(obscureText: true,
                  obscuringCharacter: "*",decoration: InputDecoration(label: Text("Enter password"),border: OutlineInputBorder()),controller: passController,),
              ),

             /* Card(child: ListTile(
                leading: Icon(Icons.picture_as_pdf,size: 22,color: Colors.amber,),
                title: Text("Add a PDF of your NID"),
                trailing: Icon(Icons.open_in_browser_outlined),
                onTap: (){
                  pickFile();
                },
              ),),*/

             Padding(

                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(

                  onPressed: () async {

                    /*final storage = FirebaseStorage.instance;
                    final storageRef2 = storage.ref();
                    final documentImageRef = storageRef2.child(
                        "teachers/${Timestamp.now()} document");
                    await documentImageRef
                        .putFile(docuFile!)
                        .whenComplete(() => documentImageRef
                        .getDownloadURL()
                        .then((get) async {
                      docUrl = get;
                    })).then((value) => signUp(nameController.text.trim(),emailController.text.trim(), passController.text.trim(),context,docUrl));


                  },      style: ElevatedButton.styleFrom(
                    fixedSize: const Size(200, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(70))),
                  child: const Text('Sign Up'),),
              ),*/

            ],),
          ),


          Padding(
            padding: const EdgeInsets.only(left: 10,top: 10),
            child: TextButton(onPressed:() {
              Navigator.pop(context);
            }, child: Text("Already have account? Signin")),
          )


        ],
      ),
    );
  }
}*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetrackerapp/screen/home_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import '../../model/FirebaseAuth.dart';

class SignUpScreen extends StatefulWidget {

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var passController=TextEditingController();
  // File? docuFile;
  // String docUrl='';
  // pickFile() async {
  //  FilePickerResult? result = await FilePicker.platform.pickFiles();
  //   if (result != null) {
  //   setState(() {
  //    docuFile = File(result.files.single.path.toString());
  //   });
  // } else {
  // User canceled the picker
  // }
  // return result;
//  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign up"),),
      body: ListView(

        children: [


          SizedBox(height: 80,),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Center(child: Text("Expense tracker",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),)),
          ),

          Card(
            elevation: 20,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
            margin: EdgeInsets.all(10),

            child: Column(children: [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(decoration: InputDecoration(label: Text("Enter name"),border: OutlineInputBorder()),controller:nameController,),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(decoration: InputDecoration(label: Text("Enter email"),border: OutlineInputBorder()),controller:emailController,),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(obscureText: true,
                  obscuringCharacter: "*",decoration: InputDecoration(label: Text("Enter password"),border: OutlineInputBorder()),controller: passController,),
              ),

              // Card(child: ListTile(
              //   leading: Icon(Icons.picture_as_pdf,size: 22,color: Colors.amber,),
              //   title: Text("Add a PDF of your NID"),
              //   trailing: Icon(Icons.open_in_browser_outlined),
              // onTap: (){
              //   pickFile();
              // },
              // ),),

              Padding(

                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(

                  onPressed: () async {

                    try {
                      // Perform the signup using Firebase Authentication
                      await FirebaseAuth.instance.createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passController.text,
                      );

                      // If the signup is successful, navigate to the HomeScreen
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    } catch (e) {
                      // Handle signup failure, e.g., display an error message
                      // You can show a SnackBar or an AlertDialog to inform the user
                      // that signup failed.
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Signup Failed'),
                            content: Text('There was an error during signup.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text('OK'),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },

                  //   final storage = FirebaseStorage.instance;
                  //   final storageRef2 = storage.ref();
                  //   final documentImageRef = storageRef2.child(
                  //       "teachers/${Timestamp.now()} document");
                  //   await documentImageRef
                  //       .putFile(docuFile!)
                  //       .whenComplete(() => documentImageRef
                  //       .getDownloadURL()
                  //       .then((get) async {
                  //     docUrl = get;
                  //   })).then((value) => signUp(nameController.text.trim(),emailController.text.trim(), passController.text.trim(),context));


                  //},
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(70))),
                  child: const Text('Sign Up'),),
              ),

            ],),
          ),


          Padding(
            padding: const EdgeInsets.only(left: 10,top: 10),
            child: TextButton(onPressed:() {
              Navigator.pop(context);
            }, child: Text("Already have account? Signin")),
          )


        ],
      ),
    );
  }
}