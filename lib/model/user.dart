import 'package:cloud_firestore/cloud_firestore.dart';

class CurrentUser {
  final String? name;
  final String? email;
  final String? gender;
  final String? age;
  final num? phoneNumber;



  CurrentUser({
    this.name,
    this.email,
    this.gender,
    this.age,
    this.phoneNumber,

  });

  factory CurrentUser.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return CurrentUser(
      name: data?['name'],
      email: data?['email'],
      gender: data?['gender'],
      age: data?['age'],
      phoneNumber: data?['phoneNumber'],

    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (name != null) "name": name,
      if (email != null) "email": email,
      if (gender != null) "gender": gender,
      if (age != null) "age": age,
      if (phoneNumber != null) "phoneNumber": phoneNumber,

    };
  }
}