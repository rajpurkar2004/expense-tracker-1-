
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensetrackerapp/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:provider/provider.dart';

import '../data/user.dart';

//var cart=FirebaseFirestore.instance.collection('users/${cuUser.currentUser?.uid}/cart');

// getTotal() async {
//   total=0;
//   cart.get().then(
//         (querySnapshot) {
//       querySnapshot.docs.forEach((result) {
//
//
//         productList.add(result.data()['productId']);
//         quantity[result.data()['productId']]=result.data()['quantity'];
//
//
//         total = total + result.data()['price']*result.data()['quantity'];
//       });
//     },
//   );
//   print(total);
// }

void getUser(BuildContext context){

  final docRef = FirebaseFirestore.instance.collection("User").doc(FirebaseAuth.instance.currentUser!.uid);

  docRef.get().then(
        (res) {
          //print(res.);
          Provider.of<MyUser>(context, listen: false).changeUser(CurrentUser(name:res["user name"],email: res["email"] ));
        },
    onError: (e) => print("Error completing: $e"),
  );

}

Future<void> sslCommerzGeneralCall(double amount) async {
  Sslcommerz sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
        //Use the ipn if you have valid one, or it will fail the transaction.
          ipn_url: "www.ipnurl.com",
          currency: SSLCurrencyType.BDT,
          product_category: "Food",
          sdkType: SSLCSdkType.TESTBOX,
          store_id: "shiha638640a42abdf",
          store_passwd: 'shiha638640a42abdf@ssl',
          total_amount: amount,
          tran_id: "1231321321321312"));
  sslcommerz.payNow();
}
