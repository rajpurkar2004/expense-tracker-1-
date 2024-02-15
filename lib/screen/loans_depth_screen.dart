import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/pdf_api.dart';
import '../api/pdf_invoice_api.dart';
import '../data/user.dart';
import '../model/customer.dart';
import '../model/invoice.dart';
import '../model/supplier.dart';

class LoansDepth extends StatefulWidget {
  const LoansDepth({Key? key}) : super(key: key);

  @override
  State<LoansDepth> createState() => _LoansDepthState();
}

class _LoansDepthState extends State<LoansDepth> {
  final Stream<QuerySnapshot> _usersDepth = FirebaseFirestore.instance.collection('main').doc(FirebaseAuth.instance.currentUser!.uid).collection("depth").snapshots();
  final Stream<QuerySnapshot> _usersLoans = FirebaseFirestore.instance.collection('main').doc(FirebaseAuth.instance.currentUser!.uid).collection("loans").snapshots();
  List<InvoiceItem> invoices=[];
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("My loans depths"),),
    body: ListView(
      children: [
        Text("My Depth",style: TextStyle(fontSize: 24),),
        Flexible(
          child: StreamBuilder<QuerySnapshot>(
            stream: _usersDepth,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }
              // if (snapshot.hasData) {
              //   return Text("Document does not exist");
              // }

              return Container(
                height: 200,
                child: ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                    DateTime date = DateTime.parse(
                        data['datetime'].toDate().toString());
                    invoices.add(   InvoiceItem(
                      description: data["senderName"],
                      date: date ,
                      quantity: 1,
                      vat: 0,
                      unitPrice: -data["loanamount"],
                    ));

                    return Card(
                      color: Colors.orangeAccent,
                      child: ListTile(
                        title: Text("Sender:${data['senderName']}"),
                        subtitle: Text("Sender:${data['senderEmail']}"),
                        trailing: Text("${data['loanamount']} ₹"),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ),


        Text("My Loans",style: TextStyle(fontSize: 24),),

        Flexible(
          child: StreamBuilder<QuerySnapshot>(
            stream: _usersLoans,
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading");
              }
              // if (snapshot.hasData) {
              //   return Text("Document does not exist");
              // }

              return Container(
                height: 200,
                child: ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {


                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;


                    DateTime date = DateTime.parse(
                        data['datetime'].toDate().toString());
                    invoices.add(   InvoiceItem(
                      description: data["sentto"],
                      date: date ,
                      quantity: 1,
                      vat: 0,
                      unitPrice: data["loanAmount"],
                    ));


                    return Card(
                      color: Colors.orangeAccent,
                      child: ListTile(
                        title: Text("Sent To:${data['sentto']}"),
                        subtitle: Text("Phone Number:${data['phoneNumber']}"),
                        trailing: Text("${data['loanAmount']} ₹"),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ),
        ElevatedButton(onPressed: () async {

          final date = DateTime.now();
          final dueDate = date.add(Duration(days: 7));

          final invoice = Invoice(
            supplier: Supplier(
              name: '',
              address: '',
              paymentInfo: '',
            ),
            customer: Customer(
              name: "${Provider.of<MyUser>(context, listen: false).currentUser.name}",
              address: '${Provider.of<MyUser>(context, listen: false).currentUser.email}',
            ),
            info: InvoiceInfo(
              date: date,
              dueDate: dueDate,
              description: 'My Loans And depths',
              number: '${DateTime.now().year}-9999',
            ),
            items:invoices.map((e) => e).toList(),
          );

          final pdfFile = await PdfInvoiceApi.generate(invoice);

          PdfApi.openFile(pdfFile);

        }, child:Text("Print Out Statements"))
      ],
    ),
    );
  }
}
