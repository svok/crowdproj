import 'package:crowdproj/modules/teams/TeamsState.dart';
import 'package:crowdproj/modules/teams/events/TeamEventEditRequested.dart';
import 'package:crowdproj/api/models/ApiResponse.dart';
import 'package:crowdproj/api/models/Team.dart';
import 'package:crowdproj/translations/TeamsLocalizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

import '../TeamBloc.dart';

class TeamViewWidget extends StatefulWidget {
  @override
  _TeamViewWidgetState createState() => _TeamViewWidgetState();
}

class _TeamViewWidgetState extends State<TeamViewWidget> {
  @override
  Widget build(BuildContext context) {
    final localizer = TeamsLocalizations.of(context);
    return BlocBuilder<TeamBloc, TeamsState>(builder: (context, state) {
      final team = state is TeamsStateViewing ? state.team : Team();
      final List<ApiError> errors =
          state is TeamsStateViewing ? state.errors : [];
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
                    child: Text(
                        MaterialLocalizations.of(context).closeButtonLabel),
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
    });
  }
}
