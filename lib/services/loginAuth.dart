import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pooleye/controller/organizationManagerController.dart';
import 'package:pooleye/view/lifeguardNotificationView.dart';
import 'package:pooleye/view/loginView.dart';
import 'package:pooleye/view/medicalNotificationView.dart';
import 'package:pooleye/view/orgainsationDailyreportView.dart';
import 'package:provider/provider.dart';

import '../view/medicalNotificationView.dart';

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
  var deleted;

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
            MaterialPageRoute(
                builder: (context) =>
                    ChangeNotifierProvider<OrganizationMangerprovider>(
                        create: (_) => OrganizationMangerprovider(),
                        child: BuilddailyReportList('lifeguard'))),
            (Route<dynamic> route) => false, // remove back arrow
          );
        }
        deleted = event.get("deleted");

        if (userRole == "lifeguard" && deleted == 0) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BuildList()),
            (Route<dynamic> route) => false, // remove back arrow
          );
        } else if (userRole == "medic" && deleted == 0) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => BuildReportList()),
            (Route<dynamic> route) => false, // remove back arrow
          );
        } else {
          Scaffold.of(ctx).showSnackBar(SnackBar(
            content: Text("Not Found Account"),
            backgroundColor: Theme.of(ctx).errorColor,
          ));
          setState(() {
            _isLoading = false;
          });
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
