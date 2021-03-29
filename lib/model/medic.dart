import 'package:pooleye/model/user.dart';

class Medic extends User {
  String id;
  String orgCode;
  String role;
  String email;
  Medic({this.id, this.orgCode, this.role, this.email});
  String get getorgCode {
    return orgCode;
  }

  String get getrole {
    return role;
  }

  String get getemail {
    return email;
  }

  String update() {
    return "";
  }
}
