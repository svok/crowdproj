import 'package:crowdproj/modules/teams/TeamsBloc.dart';
import 'package:crowdproj/modules/teams/TeamsEvent.dart';
import 'package:crowdproj/modules/teams/TeamsState.dart';
import 'package:crowdproj/widgets/BottomLoader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'TeamsTeamWidget.dart';

class TeamsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TeamsWidgetState();
}

class _TeamsWidgetState extends State<TeamsWidget> {
  final _scrollController = ScrollController();
//  final PostBloc _postBloc = PostBloc(httpClient: http.Client());
  final _scrollThreshold = 200.0;

  _TeamsWidgetState(): super() {
    _scrollController.addListener(_onScroll);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamsBloc, TeamsState>(
      builder: (context, state) {
        return ListView.builder(
          itemBuilder: (context, index) {
            print("BUILD ITEM $index");
//            switch (state.checkRange(index)) {
//              case TeamsRangeStatus.withinBuffer:
//                return TeamsTeamWidget(team: state.getTeam(index));
//              case TeamsRangeStatus.empty:
//              case TeamsRangeStatus.noAfter:
//              case TeamsRangeStatus.noBefore:
//                return Container();
//              case TeamsRangeStatus.beforeBuffer:
//                BlocProvider.of<TeamsBloc>(context).add(TeamsEvent.readPrev);
//                break;
//              case TeamsRangeStatus.afterBuffer:
//                BlocProvider.of<TeamsBloc>(context).add(TeamsEvent.readNext);
//                break;
//            }
//            return Center(child: CircularProgressIndicator());
            return index >= state.teams.length
                ? BottomLoader()
                : TeamsTeamWidget(team: state.getTeam(index));
          },
          itemCount: state.hasReachedMax
              ? state.length
              : state.length + 1,
          controller: _scrollController,
        );
      },
    );
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    print("OnSCROLL: ${maxScroll}, $currentScroll");
    if (maxScroll - currentScroll <= _scrollThreshold) {
      BlocProvider.of<TeamsBloc>(context).add(TeamsEvent.readNext);
    }
  }
}
