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
import '../widget/expense_card.dart';

class PdfPage extends StatefulWidget {
  @override
  _PdfPageState createState() => _PdfPageState();
}

class _PdfPageState extends State<PdfPage> {
   List<InvoiceItem> invoices=[];
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('main/${FirebaseAuth.instance.currentUser?.uid}/transactions/')
      .snapshots();
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Print Statement"),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(32),
          child: Center(
            child: ListView(


              children: <Widget>[




                Container(
                  height: 300,
                  child: Container(


                    child: StreamBuilder<QuerySnapshot>(
                      stream: _usersStream,
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Text("Loading");
                        }

                        return ListView(
                          children: snapshot.data!.docs.map((DocumentSnapshot document) {
                            Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

                            DateTime date = DateTime.parse(
                                data['datetime'].toDate().toString());
                            invoices.add(   InvoiceItem(
                              description: data["description"],
                              date: date ,
                              quantity: 1,
                              vat: 0,
                              unitPrice: data["expense"]==0?data["income"]:-data["expense"],
                            ));
                            return ExpenseCard(title: data["title"],subtitle: data["description"],amount: data["expense"]==0?data["income"].toString():data["expense"].toString(),date: data["datetime"],icondata: data["category"],);
                          }).toList(),
                        );

                      },
                    ),
                  ),
                ),

                const SizedBox(height: 48),
                ElevatedButton(
                  child: Text("Create a statement"),
                  onPressed: () async {
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
                        description: 'My Balance Book',
                        number: '${DateTime.now().year}-9999',
                      ),
                      items:invoices.map((e) => e).toList(),
                    );

                    final pdfFile = await PdfInvoiceApi.generate(invoice);

                    PdfApi.openFile(pdfFile);
                  },
                ),
              ],
            ),
          ),
        ),
      );
}
