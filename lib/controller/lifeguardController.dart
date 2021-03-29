import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pooleye/model/lifeguard.dart';

class Lifeguardprovider with ChangeNotifier {
  List<Lifeguard> lifeguard = [];
  Future<void> fetchdata() async {
    await Firebase.initializeApp();
    try {
      var snaps = FirebaseFirestore.instance.collection('users');
      snaps.snapshots().listen((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((document) async {
          if (document.data()['role'] == "lifeguard") {
            lifeguard.add(Lifeguard(
              id: await document.id,
              orgCode: await document.data()['organisationCode'],
              role: await document.data()['role'],
              email: await document.data()['email'],
            ));
          }
        });
        snaps.get().then((value) {
          notifyListeners();
        });
      });
    } catch (error) {
      notifyListeners();
    }
  }
}
