import 'package:crowdproj/api/models/ApiResponse.dart';
import 'package:crowdproj/api/models/Team.dart';
import 'package:crowdproj/translations/TeamsLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';


class TeamViewWidget extends StatelessWidget {
  TeamViewWidget({
    Key key,
    @required this.team,
    this.errors,
  }) : super(key: key);

  final Team team;
  final List<ApiError> errors;

  @override
  Widget build(BuildContext context) {
    final localizer = TeamsLocalizations.of(context);
    return Container(
      margin: EdgeInsets.all(15),
      child: Card(
        child: new ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.group),
              title: Text(team?.name ?? ""),
              subtitle: Text(team?.summary ?? ""),
            ),
            MarkdownBody(data: team?.description ?? ""),
          ],
        ),
      ),
    );
  }
}
