import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MedicReport {
  String id;
  String comment;
  String orgId;
  Timestamp date;

  MedicReport({
    @required this.id,
    @required this.comment,
    @required this.orgId,
    @required this.date,
  });
}
