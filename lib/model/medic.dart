import 'package:pooleye/model/user.dart';

class Medic extends User {
  String id;
  String orgCode;
  String role;
  String email;
  int deleted;
  Medic({this.id, this.orgCode, this.role, this.email, this.deleted});
  String get getorgCode {
    return orgCode;
  }

  String get geId {
    return id;
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
