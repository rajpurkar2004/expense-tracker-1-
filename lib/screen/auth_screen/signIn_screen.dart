import 'package:expensetrackerapp/screen/auth_screen/resetpassword.dart';
import 'package:expensetrackerapp/screen/auth_screen/signup_screen.dart';
import 'package:flutter/material.dart';
import '../../model/FirebaseAuth.dart';

class SignInScreen extends StatefulWidget {

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var passController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Sign In"),),
      body: ListView(

        children: [

          SizedBox(height: 80,),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Center(child: Text("Expense Tracker",style: TextStyle(fontSize: 35,fontWeight: FontWeight.bold),)),
          ),

          Card(

            elevation: 20,
          shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
          ),
            margin: EdgeInsets.all(10),
            child: Column(children: [


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(decoration: InputDecoration(label: Text("Enter email"),border: OutlineInputBorder()),controller:emailController,),
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(obscureText: true,
                obscuringCharacter: "*",decoration: InputDecoration(label: Text("Enter password"),border: OutlineInputBorder()),controller: passController,),
            ),

              Padding(
                padding: const EdgeInsets.only(right: 180),
                child: TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder:(context) => Changepassword()));}, child: Text("Forget password? Click here")),
              ),


              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ElevatedButton(onPressed: ()=>signIn(emailController.text.trim(), passController.text.trim(),context),
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(200, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(70))),
                  child: const Text('Sign In'),

                ),
              ),
          ],),),





          TextButton(onPressed:() {
            Navigator.push(context, MaterialPageRoute(builder:(context) => SignUpScreen()));
          }, child: Text("Don't have an account? Sign Up"))

        ],
      ),
    );
  }
}
