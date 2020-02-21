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
    this.canJoin: false,
    this.canUpdate: false,
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

  /**
   * Whether current user is allowed to join the team with no permission from
   * other persons
   */
  bool canJoin;

  /**
   * Whether current user is allowed to update the team.
   */
  bool canUpdate;

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
    bool canJoin,
    bool canUpdate,
  }) => Team(
    id: id ?? this.id,
    name: name ?? this.name,
    summary: summary ?? this.summary,
    description: description ?? this.description,
    owner: owner ?? this.owner,
    visibility: visibility ?? this.visibility,
    joinability: joinability ?? this.joinability,
    status: status ?? this.status,
    relation: relation ?? this.relation,
    canJoin: canJoin ?? this.canJoin,
    canUpdate: canUpdate ?? this.canUpdate,
  );

//  bool get canJoin => joinability == TeamJoinability.byUser;
}
