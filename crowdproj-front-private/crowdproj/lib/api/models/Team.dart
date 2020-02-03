import 'Profile.dart';
import 'TeamJoinability.dart';
import 'TeamStatus.dart';
import 'TeamVisibility.dart';

class Team {
  Team({
    this.id,
    this.name,
    this.summary,
    this.description,
    this.owner,
    this.visibility,
    this.joinability,
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
   * Team joinability is a type of join restrictions to theas team
   */
  TeamJoinability joinability;

  /**
   * Team status
   */
  TeamStatus status;

}
