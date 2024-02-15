import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String? title;
  final String? description;
  final Timestamp? datetime;
  final double? expense;
  final double? income;
  final String? category;


  TransactionModel({
    this.title,
    this.description,
    this.datetime,
    this.expense,
    this.income,
    this.category,
  });

  factory TransactionModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return TransactionModel(
      title: data?['title'],
      description: data?['description'],
      datetime: data?['datetime'],
      expense: data?['expense'],
      income: data?['income'],
      category: data?['category'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (title != null) "title": title,
      if (description != null) "description": description,
      if (datetime != null) "datetime": datetime,
      if (expense != null) "expense": expense,
      if (income != null) "income": income,
      if (category != null) "category": category,
    };
  }
}