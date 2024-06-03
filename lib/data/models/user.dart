// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String displayName;
  String email;
  String password;
  String role;

  UserData({
    required this.displayName,
    required this.email,
    required this.password,
    required this.role,
  });
  UserData.formJson(Map<String, Object>? json)
      : this(
          displayName: json?['displayName']! as String,
          email: json?['email']! as String,
          password: json?['password']! as String,
          role: json?['role']! as String,
        );
  UserData copyWith({
    String? displayName,
    String? email,
    String? password,
    String? role,
  }) {
    return UserData(
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      password: password ?? this.password,
      role: role ?? this.role,
    );
  }

  Map<String, Object?> toJson() {
    return {
      'displayName': displayName,
      'email': email,
      'password': password,
      'role': role,
    };
  }

  static fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> e) {}
}
