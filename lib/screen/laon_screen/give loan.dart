import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/user.dart';
import '../../function/firebase.dart';

class GiveLoanScreen extends StatefulWidget {
  const GiveLoanScreen({Key? key}) : super(key: key);

  @override
  State<GiveLoanScreen> createState() => _GiveLoanScreenState();
}

class _GiveLoanScreenState extends State<GiveLoanScreen> {

  var amountController=TextEditingController();
  var emailController=TextEditingController();
  var phoneController=TextEditingController();
  var transactionController=TextEditingController();
  var searchController=TextEditingController();
  var email='';


  Future<void> _showMyDialog(String url) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text('NID of User'),
          content: SingleChildScrollView(
            child: ListBody(
              children:  <Widget>[
                Image.network(url)
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child:  Text('Copy Download'),
              onPressed: () async {

                Clipboard.setData(ClipboardData(text: url));
                  //
                  // await ImageDownloader.downloadImage("$url").whenComplete(() =>ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  //   content:
                  //   Text('Image downloaded.'),
                  // )));

                  Navigator.pop(context);



              },
            ),
          ],
        );
      },
    );
  }


   Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('User').where("email",isEqualTo: "").snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Give Loan"),),
    body: ListView(children: [

      Padding(
        padding: EdgeInsets.all(10),
        child: TextField(
          keyboardType: TextInputType.emailAddress,
           controller: emailController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'User Email',
            hintText: "Search user by email"
          ),
        ),
      ),


    Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(

          onPressed: (){
          setState(() {
            _usersStream = FirebaseFirestore.instance.collection('User').where("email",isEqualTo: "${emailController.text}").snapshots();
          });
      }, child: Text("Search")),
    ),


    Container(
        height: 600,
        child:  StreamBuilder<QuerySnapshot>(
      stream:_usersStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text("Loading"));
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
            return Column(
              children: [
                Card(
                  child: ListTile(
                    title: Text(data['user name']),
                    subtitle: Text(data['email']),
                    trailing: Icon(Icons.supervised_user_circle_sharp),
                    onTap: () {
                      if(data['nid']==''){

                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                          Text('No NID is available for the user'),
                        ));
                      }
                      else{
                        _showMyDialog(data['nid']);
                      }

                    },
                  ),
                ),


                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    controller: amountController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Amount',
                    ),
                  ),
                ),


                Padding(
                  padding: EdgeInsets.all(10),
                  child: TextField(

                    controller: transactionController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Transaction number',
                    ),
                  ),
                ),
                ElevatedButton(onPressed: (){


                  FirebaseFirestore.instance.collection('User').where("email",isEqualTo:emailController.text ).get().then(
                          (res) {
                        if (res.docs[0].id==0){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                            const Text('Loan Send Failed'),
                          ));
                        }
                        FirebaseFirestore.instance.collection("main").doc(res.docs[0].id).collection("depth").add(
                            {
                              "loanamount":double.parse(amountController.text),
                              "senderName":Provider.of<MyUser>(context, listen: false).currentUser.name,
                              "senderEmail":emailController.text,
                              "phoneNumber":phoneController.text,
                              "transaction":transactionController.text,
                              "datetime":DateTime.now(),

                            }).whenComplete(() {

                          FirebaseFirestore.instance.collection("main").doc(FirebaseAuth.instance.currentUser!.uid).collection("loans").add({

                            "sentto":emailController.text,
                            "phoneNumber":phoneController.text,
                            "loanAmount":double.parse(amountController.text),
                            "datetime":DateTime.now(),

                          }).whenComplete(() {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                              const Text('Loan send.'),
                            ));
                            Navigator.pop(context);
                          }).catchError(()=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                            const Text('Loan Send Failed'),
                          )));




                        });


                      }
                  );


                }, child: Text("Give Loan"))

              ],
            );
          }).toList(),
        );
      },
    )),


    ],),
    );
  }
}
