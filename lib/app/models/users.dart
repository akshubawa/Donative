import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UsersData {
  List<Users> users;

  UsersData({
    required this.users,
  });

  factory UsersData.fromJson(Map<String, dynamic> json) {
    return UsersData(
      users: (json['users'] as List<dynamic>)
          .map((e) => Users.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'users': users.map((e) => e.toJson()).toList(),
    };
  }
}

class Users {
  String? address;
  Timestamp? dob;
  num donatedAmount;
  String? profilePic;
  String email;
  String phone;
  String uid;
  String? gender;
  String lastName;
  String firstName;

  Users({
    this.address, 
    this.dob,
    required this.donatedAmount,
    this.profilePic,
    required this.email,
    required this.phone,
    required this.uid,
    this.gender,
    required this.lastName,
    required this.firstName,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      uid: json['uid'] as String,
      donatedAmount: json['donatedAmount'] as num,
      profilePic: json['profilePic'] as String?,
      dob: json['dob'] as Timestamp?,
      gender: json['gender'] as String?,
      address: json['address'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'email': email,
      'uid': uid,
      'donatedAmount': donatedAmount,
      'profilePic': profilePic,
      'dob': dob,
      'gender': gender,
      'address': address,
    };
  }
}

UsersData userDataFromJson(String str) {
  final jsonData = json.decode(str) as Map<String, dynamic>;
  return UsersData.fromJson(jsonData);
}

String userDataToJson(UsersData data) {
  final dyn = data.toJson();
  return json.encode(dyn);
}
