import 'package:crowdproj/api/ITeamsService.dart';
import 'package:crowdproj/common/AppSession.dart';
import 'package:crowdproj/widgets/ActivitySpinner.dart';
import 'package:crowdproj/widgets/BottomLoader.dart';
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
  final _scrollThreshold = 200.0;

  _TeamsWidgetState() : super() {
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamsBloc, TeamsState>(
      builder: (context, state) {
        print("TEAMS BLOC state ${state.runtimeType}");
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
                        : TeamsTeamWidget(team: state.getTeam(index));
                  },
                  itemCount:
                      state.hasReachedMax ? state.length : state.length + 1,
                  controller: _scrollController,
                ),
              ),
              ChangeNotifierProvider.value(
                value: AppSession.get.teamsService,
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

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
//    print("OnSCROLL: ${maxScroll}, $currentScroll");
    if (maxScroll - currentScroll <= _scrollThreshold) {
      BlocProvider.of<TeamsBloc>(context).add(TeamsEventReadNext());
    }
  }
}
