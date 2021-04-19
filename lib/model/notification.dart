import 'package:flutter/material.dart';

class LifeguardNotification {
  String id;
  String text;
  String orgId;
  bool sent;

  LifeguardNotification({
    @required this.id,
    @required this.text,
    @required this.orgId,
    @required this.sent,
  });
}
