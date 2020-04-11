import 'package:crowdproj_teams/translations/TeamsLocalizations.dart';
import 'package:crowdproj_teams_models/models/ApiResponse.dart';
import 'package:crowdproj_teams_models/models/Team.dart';
import 'package:crowdproj_teams_models/models/TeamAccess.dart';
import 'package:crowdproj_teams_models/models/TeamRelations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'TeamViewBloc.dart';

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
    final topContentText = Theme(
      data: ThemeData.dark(),
      child: Builder(
        builder: (context) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              team?.name ?? "",
              style: chooseTitleTextStyle(context, team?.name ?? ""),
            ),
            SizedBox(height: 30.0),
            Container(
              alignment: Alignment.topRight,
              child: _applyButton(context, team),
            ),
          ],
        ),
      ),
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(
              image: AssetImage("assets/pages-teams-default-photo.jpeg"),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Color.fromRGBO(58, 66, 86, .90),
                BlendMode.srcOver,
              ),
            ),
          ),
          child: Container(
            padding: EdgeInsets.all(40.0),
            width: MediaQuery.of(context).size.width,
//          decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, .05)),
            child: Center(
              child: topContentText,
            ),
          ),
        ),
      ],
    );

    final bottomContentText = Markdown(
      shrinkWrap: true,
      data: team?.description ?? "",
    );

    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[
            bottomContentText,
          ],
        ),
      ),
    );

    return Scrollbar(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            topContent,
            bottomContent,
          ],
        ),
      ),
    );
  }

  TextStyle chooseTitleTextStyle(BuildContext context, String title) {
    final len = title.length;
//    final width = MediaQuery.of(context).size.width;
//    final double pixPerSymbol = width/len;
    final theme = Theme.of(context).textTheme;
    if (len < 8) return theme.headline1;
    if (len < 16) return theme.headline2;
    if (len < 24) return theme.headline3;
    if (len < 32) return theme.headline4;
    if (len < 48) return theme.headline5;
    return theme.headline6;
  }

  Widget _applyButton(BuildContext context, Team team) {
    final localizer = TeamsLocalizations.of(context);
    final bloc = BlocProvider.of<TeamViewBloc>(context);

    if (team == null) return Container();
    final theme = Theme.of(context).textTheme;
    return Wrap(
      alignment: WrapAlignment.end,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: <Widget>[
        if (team.can(TeamAccess.JOIN))
          FlatButton.icon(
            icon: Icon(FontAwesomeIcons.link),
            label: Text(localizer.labelJoinTeam),
            onPressed: bloc.joinAction,
          ),
        if (team.can(TeamAccess.LEAVE))
          FlatButton.icon(
            icon: Icon(FontAwesomeIcons.unlink),
            label: Text(localizer.labelLeaveTeam),
            onPressed: bloc.leaveAction,
          ),
        if (team.can(TeamAccess.APPLY))
          FlatButton.icon(
            icon: Icon(FontAwesomeIcons.link),
            label: Text(localizer.labelApplyTeam),
            onPressed: bloc.applyAction,
          ),
        if (team.can(TeamAccess.UNAPPLY))
          FlatButton.icon(
            icon: Icon(FontAwesomeIcons.unlink),
            label: Text(localizer.labelUnapplyTeam),
            onPressed: bloc.unapplyAction,
          ),
        if (team.can(TeamAccess.ACCEPT_INVITATION))
          FlatButton.icon(
            icon: Icon(FontAwesomeIcons.checkSquare),
            label: Text(localizer.labelTeamAcceptInvitation),
            onPressed: bloc.acceptInvitationAction,
          ),
        if (team.can(TeamAccess.DENY_INVITATION))
          FlatButton.icon(
            icon: Icon(FontAwesomeIcons.windowClose),
            label: Text(localizer.labelTeamDenyInvitation),
            onPressed: bloc.denyInvitationAction,
          ),
        if (team.can(TeamAccess.INVITE))
          FlatButton.icon(
            icon: Icon(FontAwesomeIcons.userPlus),
            label: Text(localizer.labelTeamInvite),
            onPressed: bloc.inviteAction,
          ),
        if (team.relation == TeamRelations.own)
          Text(
            localizer.labelOwnTeam,
            style: theme.headline5,
          ),
      ],
    );
  }
}
