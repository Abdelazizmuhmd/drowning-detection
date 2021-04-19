import 'package:flutter/material.dart';

class User {
  String id;
  String username;
  String role;
  String orgCode;
  String email;
  String password;
  String profileImage;
  User({
    @required this.id,
    @required this.email,
    @required this.role,
    @required this.orgCode,
    @required this.username,
    @required this.password,
    @required this.profileImage,
  });

  String get getUsername {
    return username;
  }

  String get getEmail {
    return email;
  }

  String get getRole {
    return role;
  }

  String get getorgCode {
    return orgCode;
  }

  String get getProfileImage {
    return profileImage;
  }
}
