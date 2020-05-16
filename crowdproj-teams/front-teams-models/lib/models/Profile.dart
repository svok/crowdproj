
import 'ProfileStatus.dart';

class Profile {
  Profile({
    this.id,
    this.alias,
    this.fName,
    this.lName,
    this.mName,
    this.phone,
    this.email,
    this.status,
  }) : super();

  String id;
  String alias;
  String fName;
  String lName;
  String mName;
  String email;
  String phone;
  ProfileStatus status;
}
