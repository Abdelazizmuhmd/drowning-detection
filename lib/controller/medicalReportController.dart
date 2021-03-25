import 'package:flutter/cupertino.dart';
import 'package:pooleye/model/lifeguardReport.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class MedicReportController {
  MedicReportController() {}
  void addMedicReport({id, comment, orgId}) {
    var now = new DateTime.now();
    Firestore.instance.collection("medicreports").document(id).setData({
      'comment': comment,
      'date': now,
      'orgID': orgId,
    });
  }
}
