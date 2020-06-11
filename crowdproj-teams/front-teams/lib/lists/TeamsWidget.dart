import 'package:crowdproj_common/widgets/ActivitySpinner.dart';
import 'package:crowdproj_common/widgets/BottomLoader.dart';
import 'package:crowdproj_teams/TeamsModule.dart';
import 'package:crowdproj_teams_models/ITeamsService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'TeamsBloc.dart';
import 'TeamsEventReadNext.dart';
import 'TeamsEventUpdate.dart';
import 'TeamsState.dart';
import 'TeamsTeamWidget.dart';

class TeamsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TeamsWidgetState();
}

class _TeamsWidgetState extends State<TeamsWidget> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 20.0;

  _TeamsWidgetState() : super() {
    _scrollController.addListener(_onScroll);
  }

  TeamsState teamsState = TeamsState();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamsBloc, TeamsState>(
      builder: (context, state) {
        teamsState = state;
        return ActivitySpinner(
          isWaiting: state?.isWaiting,
          child: Stack(
            alignment: AlignmentDirectional.topStart,
            children: <Widget>[
              Scrollbar(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return index >= state.teams.length
                        ? BottomLoader()
                        : TeamsTeamWidget(team: state.teams[index]);
                  },
                  itemCount:
                      state.hasReachedMax ? state.length : state.length + 1,
                  controller: _scrollController,
                ),
              ),
              ChangeNotifierProvider.value(
                value: TeamsModule().transportService,
                child:
                    Consumer<ITeamsService>(builder: (context, value, child) {
                  return value.isUptodate
                      ? Container()
                      : Container(
                          alignment: AlignmentDirectional.topEnd,
                          child: IconButton(
                            icon: Icon(Icons.refresh),
                            onPressed: () {
                              BlocProvider.of<TeamsBloc>(context)
                                  .add(TeamsEventUpdate());
                            },
                          ),
                        );
                }),
              ),
            ],
          ),
        );
      },
    );
  }

  int sizeFlag = 0;

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
      if (teamsState.length != sizeFlag) {
        sizeFlag = teamsState.length;
        BlocProvider.of<TeamsBloc>(context).add(TeamsEventReadNext());
      }
    }
  }
}
