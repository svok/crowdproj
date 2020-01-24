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
        visibility: team.visibility.toVisibility(),
        status: team.status.toStatus()
      );

//  static TeamVisibility visibilityFromExchange(String visibility) {
//    switch (visibility) {
//      case 'public':
//        return TeamVisibility.public;
//      case 'registeredOnly':
//        return TeamVisibility.registeredOnly;
//      case 'groupOnly':
//        return TeamVisibility.groupOnly;
//      case 'membersOnly':
//        return TeamVisibility.membersOnly;
//      default:
//        return TeamVisibility.public;
//    }
//  }

//  static String visibilityToExchange(TeamVisibility visibility) {
//    return visibility.toString();
//  }
}

enum TeamVisibility { public, registeredOnly, groupOnly, membersOnly }

enum TeamStatus { active, pending, closed, deleted }

extension EnumParser on String {
  TeamVisibility toVisibility() {
    return TeamVisibility.values.firstWhere(
            (e) => e.toString().toLowerCase() == this.toLowerCase(),
        orElse: () => null); //return null if not found
  }
  TeamStatus toStatus() {
    return TeamStatus.values.firstWhere(
            (e) => e.toString().toLowerCase() == this.toLowerCase(),
        orElse: () => null); //return null if not found
  }
}
