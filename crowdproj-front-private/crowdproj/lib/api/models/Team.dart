import 'Profile.dart';
import 'TeamJoinability.dart';
import 'TeamRelations.dart';
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
    this.relation,
    this.cans,
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

  /**
   * Relationship of the team to the current user
   */
  TeamRelations relation;

  List<String> cans = [];

  /**
   * Whether current user is allowed to join the team with no permission from
   * other persons
   */
  bool get canJoin => cans.contains("join");

  set canJoin(bool value) {
    if (value)
      cans.add("join");
    else
      cans.remove("join");
  }

  /**
   * Whether current user is allowed to apply for membership in this team
   */
  bool get canApply => cans.contains("apply");
  set canApply(bool value) {
    if (value)
      cans.add("apply");
    else
      cans.remove("apply");
  }

  /**
   * Whether current user is allowed to leave this team
   */
  bool get canLeave => cans.contains("leave");
  set canLeave(bool value) {
    if (value)
      cans.add("leave");
    else
      cans.remove("leave");
  }

  /**
   * Whether current user is allowed to update the team.
   */
  bool get canUpdate => cans.contains("update");
  set canUpdate(bool value) {
    if (value)
      cans.add("update");
    else
      cans.remove("update");
  }

  @override
  String toString() => "Team{id=$id, name=$name}";

  Team copyWith({
    String id,
    String name,
    String summary,
    String description,
    Profile owner,
    TeamVisibility visibility,
    TeamJoinability joinability,
    TeamStatus status,
    TeamRelations relation,
    List<String> cansJoin,
  }) =>
      Team(
        id: id ?? this.id,
        name: name ?? this.name,
        summary: summary ?? this.summary,
        description: description ?? this.description,
        owner: owner ?? this.owner,
        visibility: visibility ?? this.visibility,
        joinability: joinability ?? this.joinability,
        status: status ?? this.status,
        relation: relation ?? this.relation,
        cans: cans ?? this.cans,
      );

//  bool get canJoin => joinability == TeamJoinability.byUser;
}
