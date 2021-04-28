import 'package:pooleye/model/user.dart';

class OrganisationManager extends User {
  String id;
  String orgCode;
  String role;
  String orgName;
  String email;

  OrganisationManager(
      {this.id, this.orgCode, this.role, this.email, this.orgName});
  String get getorgCode {
    return orgCode;
  }

  String get getrole {
    return role;
  }
}
