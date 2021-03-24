import 'package:flutter/material.dart';
import 'package:pooleye/model/lifeguardReport.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class LifeguardReportController {
  Stream<List<LifeguardReport>> lifeguardreport;
  LifeguardReportController() {}
  Future<void> fetchLifeguardReports() async {
    await Firebase.initializeApp();
    lifeguardreport = Firestore.instance
        .collection("lifeguardreports")
        .snapshots()
        .map((event) => event.documents
            .map((DocumentSnapshot documentSnapshot) => LifeguardReport(
                id: documentSnapshot.documentID,
                text: documentSnapshot.data()['text']))
            .toList());
  }
}
