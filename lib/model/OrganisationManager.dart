import 'package:pooleye/model/user.dart';

class OrganisationManager extends User {
  String id;
  String orgCode;
  String role;

  OrganisationManager({this.id, this.orgCode, this.role});
  String get getorgCode {
    return orgCode;
  }

  String get getrole {
    return role;
  }
}
