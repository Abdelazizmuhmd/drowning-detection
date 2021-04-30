import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pooleye/view/lifeguardNotificationView.dart';
import 'package:pooleye/view/medicalNotificationView.dart';
import 'package:pooleye/view/orgainsationDailyreportView.dart';
import 'package:pooleye/view/signupView.dart';
import 'dart:math';

class AuthForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AuthFormState();
  }
}

class AuthFormState extends State<AuthForm> {
  final _auth = FirebaseAuth.instance;
  UserCredential userCredential;
  bool _isLoading = false;
  String profileImage = null;
  var rng = new Random();
FirebaseMessaging firebaseMessaging = new FirebaseMessaging();

  bool codeCheck = true;
  bool usernameCheck = true;
  void _submitAuthForm(String orgainsationName, String role, String email,
      String password, BuildContext ctx,
      [String organisationCode, String username]) async {
    var codeId = rng.nextInt(10000);
    var genrated = DateTime.now().millisecondsSinceEpoch;
    var fullOrgCode =
        orgainsationName + codeId.toString() + genrated.toString();

    if (role == "organisationManager") {
      try {
        setState(() {
          _isLoading = true;
        });

        userCredential = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user.uid)
            .set({
          'email': email,
          'orgainsationName': orgainsationName,
          'orgCode': fullOrgCode,
          'role': role,
          'profileImage': profileImage,
        });
    firebaseMessaging.subscribeToTopic(fullOrgCode+role);
    print(fullOrgCode+role);


        FirebaseFirestore.instance
            .collection('organisations')
            .doc(fullOrgCode)
            .set({
          'orgCode': fullOrgCode,
          'orgainsationName': orgainsationName,
        });

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => BuilddailyReportList('lifeguard')),
          (Route<dynamic> route) => false, // remove back arrow
        );
      } on FirebaseAuthException catch (e) {
        String message = "error Occured";
        if (e.code == 'weak-password') {
          message = "The password provided is too weak";
        } else if (e.code == 'email-already-in-use') {
          message = "The account already exists for that email";
        }
        Scaffold.of(ctx).showSnackBar(SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ));
        setState(() {
          _isLoading = false;
        });
      } catch (e) {
        print(e);
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      await FirebaseFirestore.instance
          .collection("organisations")
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((result) {
          if (organisationCode == result["orgCode"]) {
            return codeCheck = false;
          }
        });
      });

      if (codeCheck == true) {
        Scaffold.of(ctx).showSnackBar(SnackBar(
          content: Text("Invalid Code"),
          backgroundColor: Theme.of(ctx).errorColor,
        ));
      }

      if (codeCheck == false) {
        try {
          setState(() {
            _isLoading = true;
          });

          userCredential = await _auth.createUserWithEmailAndPassword(
              email: email, password: password);

          //String fcmToken = await fbm.getToken();
          FirebaseFirestore.instance
              .collection('users')
              .doc(userCredential.user.uid)
              .set({
            'email': email,
            'orgainsationName': orgainsationName,
            'orgCode': organisationCode,
            'role': role,
            'profileImage': profileImage,
            'deleted': 0,
            'username': username,
            'subscriber': true
          });

          if (role == "lifeguard") {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => BuildList()),
              (Route<dynamic> route) => false, // remove back arrow
            );
          }

          if (role == "medic") {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => BuildReportList()),
              (Route<dynamic> route) => false, // remove back arrow
            );
          }
        } on FirebaseAuthException catch (e) {
          String message = "error Occured";
          if (e.code == 'weak-password') {
            message = "The password provided is too weak";
          } else if (e.code == 'email-already-in-use') {
            message = "The account already exists for that email";
          }
          Scaffold.of(ctx).showSnackBar(SnackBar(
            content: Text(message),
            backgroundColor: Theme.of(ctx).errorColor,
          ));
          setState(() {
            _isLoading = false;
          });
        } catch (e) {
          print(e);
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  Color c1 = const Color.fromRGBO(
      110, 204, 234, 1.0); // fully transparent white (invisible)
  final _formKey = GlobalKey<FormState>();
  static final validCharacters = RegExp(r"^[a-zA-Z]+$");
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Signup(_submitAuthForm, _isLoading),
    );
  }
}
