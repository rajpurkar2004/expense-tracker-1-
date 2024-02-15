import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import '../model/user.dart';

class MyUser extends ChangeNotifier{


  var expesne = FirebaseFirestore.instance.collection('main/${FirebaseAuth.instance.currentUser?.uid}/transactions/').snapshots();

  var exp= FirebaseFirestore.instance.collection('main/${FirebaseAuth.instance.currentUser?.uid}/transactions/').where('datetime', isGreaterThan:  DateTime.parse("2021-12-26"))
      .where('datetime', isLessThan: DateTime.parse("2023-12-30")).snapshots();

  void anyexpense(){
    expesne = FirebaseFirestore.instance.collection('main/${FirebaseAuth.instance.currentUser?.uid}/transactions/').snapshots();
  }


  void timeIncome(String previous,String current){
    expesne = FirebaseFirestore.instance.collection('main/${FirebaseAuth.instance.currentUser?.uid}/transactions/').where('datetime', isGreaterThan:   DateTime.parse("2021-12-26"))
        .where('datetime', isLessThan: DateTime.parse("2023-12-30")).snapshots();
}

  void categoryIncome(String category){
    expesne = FirebaseFirestore.instance.collection('main/${FirebaseAuth.instance.currentUser?.uid}/transactions/').where("category", isEqualTo: category).snapshots();
  }


  CurrentUser currentUser=CurrentUser(email: "",gender: "",phoneNumber: 0,age: "",name: "");
  void changeUser(CurrentUser newUser){
    currentUser=newUser;
    notifyListeners();
  }



}