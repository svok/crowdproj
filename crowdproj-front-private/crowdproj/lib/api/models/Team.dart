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
  }) => Team(
    id: id ?? this.id,
    name: name ?? this.name,
    summary: summary ?? this.summary,
    description: description ?? this.description,
    owner: owner ?? this.owner,
    visibility: visibility ?? this.visibility,
    joinability: joinability ?? this.joinability,
    status: status ?? this.status,
    relation: relation ?? this.relation
  );

  bool get canJoin => joinability == TeamJoinability.byUser;
}
