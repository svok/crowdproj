import 'package:crowdproj_models/model/team.dart' as exchange;

import 'Profile.dart';

class Team {
  Team({
    this.id,
    this.name,
    this.summary,
    this.description,
    this.owner,
    this.visibility,
    this.status,
  }) : super();

  String id;

  /**
   * Name of the team
   */
  String name = "";

  /**
   * Brief description of the team
   */
  String summary = "";

  /**
   * Full description of the team
   */
  String description = "";

  /**
   * Team owner
   */
  Profile owner;

  /**
   * Team visibility
   */
  TeamVisibility visibility;

  /**
   * Team status
   */
  TeamStatus status;

  static Team fromExchange(exchange.Team team) => Team(
      id: team.id,
      name: team.name,
      summary: team.summary,
      description: team.description,
      owner: Profile.fromExchange(team.owner),
      visibility: TeamEnumParser.toVisibility(team.visibility),
      status: TeamEnumParser.toStatus(team.status));

  exchange.Team toExchange() => toExchangeBuilder().build();

  exchange.TeamBuilder toExchangeBuilder() => exchange.TeamBuilder()
    ..id = id
    ..name = name
    ..summary = summary
    ..description = description
    ..owner = owner.toExchangeBuilder()
    ..visibility = visibility.toString()
    ..status = status.toString();
}

enum TeamVisibility { public, registeredOnly, groupOnly, membersOnly }

enum TeamStatus { active, pending, closed, deleted }

class TeamEnumParser {
  static TeamVisibility toVisibility(String str) => TeamVisibility.values
      .firstWhere((e) => e.toString().toLowerCase() == str.toLowerCase(),
          orElse: () => null); //return null if not found

  static TeamStatus toStatus(String str) => TeamStatus.values.firstWhere(
      (e) => e.toString().toLowerCase() == str.toLowerCase(),
      orElse: () => null); //return null if not found
}
