import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:pooleye/view/appMenuView.dart';
import 'package:pooleye/view/lifeguardNotificationView.dart';
import 'package:pooleye/view/medicalNotificationView.dart';
import 'package:pooleye/view/orgainsationDailyreportView.dart';
import 'package:pooleye/view/signupView.dart';
import 'dart:math';

class AuthForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AuthFormState();
  }
}

class AuthFormState extends State<AuthForm> {
  final FirebaseMessaging fbm = FirebaseMessaging();
  final _auth = FirebaseAuth.instance;
  UserCredential userCredential;
  bool _isLoading = false;
  String profileImage = null;
  var rng = new Random();

  FirebaseFirestore db = FirebaseFirestore.instance;

  bool check = true;
  void _submitAuthForm(String orgainsationName, String role, String email,
      String password, BuildContext ctx,
      [String organisationCode]) async {
    var codeId = rng.nextInt(10000);
    var genrated = DateTime.now().millisecondsSinceEpoch;

    if (role == "organisationManager") {
      await FirebaseFirestore.instance
          .collection("organisations")
          .doc(orgainsationName)
          .collection('users')
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((result) {
          if (email == result["email"]) {
            return check = false;
          }
        });
      });

      if (check == false) {
        Scaffold.of(ctx).showSnackBar(SnackBar(
          content: Text("Email already exists"),
          backgroundColor: Theme.of(ctx).errorColor,
        ));
        setState(() {
          _isLoading = false;
          check = true;
        });
      } else {
        try {
          setState(() {
            _isLoading = true;
          });

          userCredential = await _auth.createUserWithEmailAndPassword(
              email: email, password: password);

          //String fcmToken = await fbm.getToken();
          FirebaseFirestore.instance
              .collection('organisations')
              .doc(orgainsationName + codeId.toString() + genrated.toString())
              .collection('users')
              .doc(userCredential.user.uid)
              .set({
            'email': email,
            'orgainsationName': orgainsationName,
            'role': role,
            'profileImage': profileImage,
          });

          // FirebaseFirestore.instance
          //     .collection('cars')
          //     .doc(userCredential.user.uid)
          //     .set({
          //   'userid': userCredential.user.uid,
          //   'CarProfileImage': carProfileImage,
          //   'Location': car_location,
          //   'SaleStatus': saleStatus,
          //   'carModel': carModel
          // });

          // var tokens = db
          //     .collection('users')
          //     .doc(userCredential.user.uid)
          //     .collection('tokens')
          //     .doc(fcmToken);
          // await tokens.set({
          //   'token': fcmToken,
          //   'createdAt': FieldValue.serverTimestamp(), // optional
          //   'platform': Platform.operatingSystem // optional
          // });

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => daily_report()),
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
      }
    } else {
      // await FirebaseFirestore.instance
      //     .collection("organisations")
      //     .get()
      //     .then((snapshot) {
      //   snapshot.docs.forEach((doc) {
      //     if (organisationCode != doc.id) {
      //       print("CCCCCCCCCCCCCCCCCCCCCXXXXXXXXXXXXXXAGCgGG");
      //       return check = false;
      //     }
      //   });
      // });

      // final QuerySnapshot result =
      //     await FirebaseFirestore.instance.collection('organisations').get();
      // final List<DocumentSnapshot> documents = result.docs;
      // documents.forEach((data) {
      //   if (organisationCode == data.toString()) {
      //     return check = false;
      //   }
      // });

      await FirebaseFirestore.instance
          .collection("organisations")
          .doc(organisationCode)
          .collection('users')
          .get()
          .then((querySnapshot) {
        querySnapshot.docs.forEach((result) {
          if (email == result["email"]) {
            return check = false;
          }
        });
      });
      if (check == false) {
        Scaffold.of(ctx).showSnackBar(SnackBar(
          content: Text("Email already exists"),
          backgroundColor: Theme.of(ctx).errorColor,
        ));
        setState(() {
          _isLoading = false;
          check = true;
        });
      } else {
        try {
          setState(() {
            _isLoading = true;
          });

          userCredential = await _auth.createUserWithEmailAndPassword(
              email: email, password: password);

          //String fcmToken = await fbm.getToken();
          FirebaseFirestore.instance
              .collection('organisations')
              .doc(organisationCode)
              .collection('users')
              .doc(userCredential.user.uid)
              .set({
            'email': email,
            'orgainsationName': orgainsationName,
            'role': role,
            'profileImage': profileImage,
          });

          // FirebaseFirestore.instance
          //     .collection('cars')
          //     .doc(userCredential.user.uid)
          //     .set({
          //   'userid': userCredential.user.uid,
          //   'CarProfileImage': carProfileImage,
          //   'Location': car_location,
          //   'SaleStatus': saleStatus,
          //   'carModel': carModel
          // });

          // var tokens = db
          //     .collection('users')
          //     .doc(userCredential.user.uid)
          //     .collection('tokens')
          //     .doc(fcmToken);
          // await tokens.set({
          //   'token': fcmToken,
          //   'createdAt': FieldValue.serverTimestamp(), // optional
          //   'platform': Platform.operatingSystem // optional
          // });

          if (role == "lifeguard") {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => lifeguard_notify()),
              (Route<dynamic> route) => false, // remove back arrow
            );
          }

          if (role == "medic") {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => medic_notify_page()),
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
    // await FirebaseFirestore.instance
    //     .collection("organisations")
    //     .doc(email)
    //     .collection('users')
    //     .get()
    //     .then((querySnapshot) {
    //   querySnapshot.docs.forEach((result) {
    //     if (email == result["email"]) {
    //       return check = false;
    //     }
    //   });
    // });
    // if (check == false) {
    //   Scaffold.of(ctx).showSnackBar(SnackBar(
    //     content: Text("Email already exists"),
    //     backgroundColor: Theme.of(ctx).errorColor,
    //   ));
    //   setState(() {
    //     _isLoading = false;
    //     check = true;
    //   });
    // } else {
    //   try {
    //     setState(() {
    //       _isLoading = true;
    //     });

    //     userCredential = await _auth.createUserWithEmailAndPassword(
    //         email: email, password: password);

    //     //String fcmToken = await fbm.getToken();
    //     FirebaseFirestore.instance
    //         .collection('organisations')
    //         .doc(orgainsationName)
    //         .collection('users')
    //         .doc(userCredential.user.uid)
    //         .set({
    //       'email': email,
    //       'orgainsationName': orgainsationName,
    //       'role': role,
    //       'profileImage': profileImage,
    //     });

    //     // FirebaseFirestore.instance
    //     //     .collection('cars')
    //     //     .doc(userCredential.user.uid)
    //     //     .set({
    //     //   'userid': userCredential.user.uid,
    //     //   'CarProfileImage': carProfileImage,
    //     //   'Location': car_location,
    //     //   'SaleStatus': saleStatus,
    //     //   'carModel': carModel
    //     // });

    //     // var tokens = db
    //     //     .collection('users')
    //     //     .doc(userCredential.user.uid)
    //     //     .collection('tokens')
    //     //     .doc(fcmToken);
    //     // await tokens.set({
    //     //   'token': fcmToken,
    //     //   'createdAt': FieldValue.serverTimestamp(), // optional
    //     //   'platform': Platform.operatingSystem // optional
    //     // });

    //     if (role == "organisationManager") {
    //       Navigator.pushAndRemoveUntil(
    //         context,
    //         MaterialPageRoute(builder: (context) => daily_report()),
    //         (Route<dynamic> route) => false, // remove back arrow
    //       );
    //     }

    //     if (role == "lifeguard") {
    //       Navigator.pushAndRemoveUntil(
    //         context,
    //         MaterialPageRoute(builder: (context) => SideDrawer('lifeguard')),
    //         (Route<dynamic> route) => false, // remove back arrow
    //       );
    //     }

    //     if (role == "medic") {
    //       Navigator.pushAndRemoveUntil(
    //         context,
    //         MaterialPageRoute(builder: (context) => SideDrawer('medic')),
    //         (Route<dynamic> route) => false, // remove back arrow
    //       );
    //     }
    //   } on FirebaseAuthException catch (e) {
    //     String message = "error Occured";
    //     if (e.code == 'weak-password') {
    //       message = "The password provided is too weak";
    //     } else if (e.code == 'email-already-in-use') {
    //       message = "The account already exists for that email";
    //     }
    //     Scaffold.of(ctx).showSnackBar(SnackBar(
    //       content: Text(message),
    //       backgroundColor: Theme.of(ctx).errorColor,
    //     ));
    //     setState(() {
    //       _isLoading = false;
    //     });
    //   } catch (e) {
    //     print(e);
    //     setState(() {
    //       _isLoading = false;
    //     });
    //   }
    // }
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
      body: Signup(_submitAuthForm, _isLoading),
    );
  }
}
