import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LifeguardReport {
  String id;
  String comment;
  String orgId;
  Timestamp date;
  String type;
  bool sent;

  LifeguardReport(
      {@required this.id,
      @required this.comment,
      @required this.orgId,
      @required this.type,
      @required this.date,
      @required this.sent});
}
