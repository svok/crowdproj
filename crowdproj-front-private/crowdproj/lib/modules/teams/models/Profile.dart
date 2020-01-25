import 'package:crowdproj_models/model/profile.dart' as exchange;

class Profile {
  Profile({this.id}) : super();

  String id;

  static fromExchange(exchange.Profile owner) => Profile();

  exchange.Profile toExchange() => toExchangeBuilder().build();
  exchange.ProfileBuilder toExchangeBuilder() => exchange.ProfileBuilder()..id = id;
}
