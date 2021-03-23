import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pooleye/view/lifeguardNotificationView.dart';
import 'package:pooleye/view/loginView.dart';
import 'package:pooleye/view/medicalNotificationView.dart';
import 'package:pooleye/view/orgainsationDailyreportView.dart';

class AuthFormLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AuthFormLoginState();
  }
}

class AuthFormLoginState extends State<AuthFormLogin> {
  final _auth = FirebaseAuth.instance;
  UserCredential _authResult;
  bool _isLoading = false;
  var userRole;

  void _submitAuthForm_signin(
      String email, String password, BuildContext ctx) async {
    try {
      setState(() {
        _isLoading = true;
      });

      _authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      FirebaseFirestore.instance
          .collection("users")
          .doc(_authResult.user.uid)
          .snapshots()
          .listen((event) {
        userRole = event.get("role");
        if (userRole == "organisationManager") {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => daily_report()),
            (Route<dynamic> route) => false, // remove back arrow
          );
        }

        if (userRole == "lifeguard") {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => lifeguard_notify()),
            (Route<dynamic> route) => false, // remove back arrow
          );
        }

        if (userRole == "medic") {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => medic_notify_page()),
            (Route<dynamic> route) => false, // remove back arrow
          );
        }
      });
    } on FirebaseAuthException catch (e) {
      String message = "error Occured";
      if (e.code == 'user-not-found') {
        message = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        message = 'Wrong password provided for that user.';
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

  Color c1 = const Color.fromRGBO(
      110, 204, 234, 1.0); // fully transparent white (invisible)
  final _formKey = GlobalKey<FormState>();
  static final validCharacters = RegExp(r"^[a-zA-Z]+$");
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Login(_submitAuthForm_signin, _isLoading),
    );
  }
}
