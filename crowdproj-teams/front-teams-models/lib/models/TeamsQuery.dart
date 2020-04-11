import 'TeamRelations.dart';
import 'TeamStatus.dart';

class TeamsQuery {
  TeamsQuery({
    this.relation: TeamRelations.accessed,
    this.onDate,
    this.offset,
    this.limit,
    this.statuses,
    this.relations,
    this.tagIds,
  }) : super();

  TeamRelations relation;
  DateTime onDate;
  int offset = 0;
  int limit = 10;
  List<String> tagIds;
  List<TeamStatus> statuses;
  List<TeamRelations> relations;
}
