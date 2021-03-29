import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pooleye/model/OrganisationManager.dart';

class OrganisationMangerprovider with ChangeNotifier {
  List<OrganisationManager> orgManagers = [];
  Future<void> fetchdata() async {
    await Firebase.initializeApp();
    try {
      var snaps = FirebaseFirestore.instance.collection('users');
      snaps.snapshots().listen((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((document) async {
          if (document.data()['role'] == "organisationManager") {
            orgManagers.add(OrganisationManager(
              id: await document.id,
              orgCode: await document.data()['organisationCode'],
              role: await document.data()['role'],
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
