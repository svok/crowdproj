import 'package:crowdproj/api/models/TeamStatus.dart';

import 'TeamRelations.dart';

class TeamsQuery {
  TeamsQuery({
    this.onDate,
    this.offset,
    this.limit,
    this.statuses,
    this.relations,
    this.tagIds,
  }) : super();

  DateTime onDate;
  int offset = 0;
  int limit = 10;
  List<String> tagIds;
  List<TeamStatus> statuses;
  List<TeamRelations> relations;
}
