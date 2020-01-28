import 'package:crowdproj_models/model/profile.dart' as exchange;

class Profile {
  Profile({
    this.id,
    this.alias,
    this.fName,
    this.lName,
    this.mName,
    this.phone,
    this.email,
  }) : super();

  String id;
  String alias;
  String fName;
  String lName;
  String mName;
  String email;
  String phone;

  static Profile fromExchange(exchange.Profile profile) => Profile(
    id: profile.id,
    alias: profile.alias,
    fName: profile.fName,
    lName: profile.lName,
    mName: profile.mName,
    phone: profile.phone,
    email: profile.email,
  );

  exchange.Profile toExchange() => toExchangeBuilder().build();

  exchange.ProfileBuilder toExchangeBuilder() => exchange.ProfileBuilder()
    ..id = id
    ..alias = alias
    ..fName = fName
    ..lName = lName
    ..mName = mName
    ..email = email
    ..phone = phone;
}
