import 'package:crowdproj_common/common/modules/IModule.dart';
import 'package:crowdproj_teams/lists/MenuItemTeams.dart';
import 'package:crowdproj_teams/lists/MenuItemTeamsMy.dart';
import 'package:crowdproj_teams/translations/TeamsLocalizations.dart';
import 'package:crowdproj_teams_models/crowdproj_teams_models.dart';
import 'package:flutter/material.dart';

class TeamsModule implements IModule {
  TeamsModule.main({
    @required this.transportService,
    @required this.locateTo,
  }) : super();

  factory TeamsModule() {
    return _instance;
  }

  static TeamsModule _instance;

  final ITeamsService transportService;
  @override
  final LocateTo locateTo;

  void init(
      {@required ITeamsService transportService,
      @required LocateTo locateTo}) async {
    _instance = TeamsModule.main(
      transportService: transportService,
      locateTo: locateTo,
    );
  }

  @override
  List<LocalizationsDelegate> get localizations => [
    TeamsLocalizations.delegate,
  ];

  Iterable<Widget> menuItems() => [
    MenuItemTeams(),
    MenuItemTeamsMy(),
  ];

}
