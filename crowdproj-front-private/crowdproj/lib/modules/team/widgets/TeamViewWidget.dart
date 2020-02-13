import 'package:crowdproj/api/models/ApiResponse.dart';
import 'package:crowdproj/modules/team/events/TeamEventEditRequested.dart';
import 'package:crowdproj/api/models/Team.dart';
import 'package:crowdproj/translations/TeamsLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../TeamBloc.dart';

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
            ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: Text(localizer.titleUpdate),
                  onPressed: () {
                    BlocProvider.of<TeamBloc>(context)
                        .add(TeamEventEditRequested(team: team));
                  },
                ),
                FlatButton(
                  child:
                      Text(MaterialLocalizations.of(context).closeButtonLabel),
                  onPressed: () {
                    Navigator.of(context).maybePop();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
