import 'package:pooleye/model/user.dart';

class Medic extends User {
  String id;
  String orgCode;
  String role;
  String email;
  int deleted;
  String username;
  bool switcher;
  Medic(
      {this.id,
      this.orgCode,
      this.role,
      this.email,
      this.deleted,
      this.username,
      this.switcher});
  String get getorgCode {
    return orgCode;
  }

  String get getId {
    return id;
  }

  String get getrole {
    return role;
  }

  String get getemail {
    return email;
  }

  String get getusername {
    return username;
  }
}
