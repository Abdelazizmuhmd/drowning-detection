import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class GetFirebase {
  static final GetFirebase _singleton = GetFirebase._internal();
  var firebaseStorageRef = FirebaseStorage.instance.ref();
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

  get fbStorage {
    return firebaseStorageRef;
  }

  get auth {
    return FirebaseAuth.instance;
  }

  GetFirebase._internal();
}
