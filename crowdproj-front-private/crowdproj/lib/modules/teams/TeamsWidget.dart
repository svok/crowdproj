import 'package:crowdproj/modules/teams/TeamsBloc.dart';
import 'package:crowdproj/modules/teams/TeamsEvent.dart';
import 'package:crowdproj/modules/teams/TeamsState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'TeamsTeamWidget.dart';

class TeamsWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TeamsWidgetState();
}

class _TeamsWidgetState extends State<TeamsWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeamsBloc, TeamsState>(
      builder: (context, state) {
        return ListView.builder(
          itemBuilder: (context, index) {
            switch (state.checkRange(index)) {
              case TeamsRangeStatus.withinBuffer:
                return TeamsTeamWidget(team: state.getTeam(index));
              case TeamsRangeStatus.empty:
              case TeamsRangeStatus.noAfter:
              case TeamsRangeStatus.noBefore:
                return Container();
              case TeamsRangeStatus.beforeBuffer:
                BlocProvider.of<TeamsBloc>(context).add(TeamsEvent.readPrev);
                break;
              case TeamsRangeStatus.afterBuffer:
                BlocProvider.of<TeamsBloc>(context).add(TeamsEvent.readNext);
                break;
            }
            return Center(child: CircularProgressIndicator());
//            if (index < teamsList.length) {
//              // Show your info
//              return Text("$index");
//            } else {
////              getMoreData();
//              return Center(child: CircularProgressIndicator());
//            }
          },
          itemCount: 5,
        );
      },
    );
  }
}
