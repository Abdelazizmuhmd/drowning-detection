import 'package:firebase_auth/firebase_auth.dart';

class Firebase {
  String user = FirebaseAuth.instance.currentUser.uid;

  String get getUserID {
    return user;
  }
}
