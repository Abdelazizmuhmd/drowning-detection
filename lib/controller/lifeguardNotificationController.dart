import 'package:flutter/material.dart';
import 'package:pooleye/model/notification.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class LifeguardNotificationController {
  Stream<List<LifeguardNotification>> lifeguardnotification;
  LifeguardNotificationController() {}
  Future<void> fetchLifeguardReports() async {
    await Firebase.initializeApp();
    lifeguardnotification = Firestore.instance
        .collection("lifeguardnotifications")
        .snapshots()
        .map((event) => event.documents
            .map((DocumentSnapshot documentSnapshot) => LifeguardNotification(
                id: documentSnapshot.documentID,
                text: documentSnapshot.data()['text']))
            .toList());
  }
}
