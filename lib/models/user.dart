import 'package:flutter/material.dart';

class User {
  final String firstName;
  final String lastName;
  final String profileImage;
  final String phoneNumber;

  User(
      {@required this.firstName,
      @required this.lastName,
      @required this.profileImage,
      @required this.phoneNumber});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        firstName: json["name"]["first"],
        lastName: json["name"]["last"],
        profileImage: json["picture"]["large"],
        phoneNumber: json["cell"]);
  }
}
