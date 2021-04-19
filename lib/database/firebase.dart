import 'package:firebase_auth/firebase_auth.dart';

class GetFirebase {
  static final GetFirebase _singleton = GetFirebase._internal();
  bool color = true;

  bool get getcolor {
    return color;
  }

  factory GetFirebase() {
    return _singleton;
  }
  String get getUserID {
    return FirebaseAuth.instance.currentUser.uid;
  }

  GetFirebase._internal();
}
