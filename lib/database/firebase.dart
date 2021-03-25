import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetFirebase {
  String user = FirebaseAuth.instance.currentUser.uid;
  String orgCode = "";
  String role = "";
  String get getUserID {
    return user;
  }

  String get getOrgCode {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user)
        .snapshots()
        .listen((event) {
      orgCode = event.get("organisationCode");
    });

    return orgCode;
  }

  String get getRole {
    FirebaseFirestore.instance
        .collection("users")
        .doc(user)
        .snapshots()
        .listen((event) {
      role = event.get("role");
    });

    return role;
  }
}
