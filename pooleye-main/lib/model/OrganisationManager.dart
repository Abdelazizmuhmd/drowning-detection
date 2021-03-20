import 'package:flutter/material.dart';
import 'package:pooleye/model/user.dart';

class OrganisationManager extends User {
  String organisationID;
  OrganisationManager({
    @required this.organisationID,
  });

  String get getOrganisationID {
    return organisationID;
  }
}
