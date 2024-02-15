import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../function/data.dart';
class ExpenseCard extends StatelessWidget {
  const ExpenseCard({Key? key, required this.title, required this.subtitle, required this.amount, required this.date, required this.icondata}) : super(key: key);
  final String title;
  final String subtitle;
  final String amount;
  final Timestamp date;
  final String icondata;

  @override
  Widget build(BuildContext context) {
    return Card(
    child: ListTile(
    leading: Icon(icons[icondata],color: Colors.deepOrangeAccent,),
  title: Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 24),),
  subtitle: Text(subtitle),
  trailing:Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
    Text("৳$amount"),
      Text("${DateFormat.d().format(date.toDate())} ${DateFormat.MMM().format(date.toDate())}"),

  ],) ,

  ),
  );
  }
}
