import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import 'NavigatorAction.dart';

class NavigatorBloc extends Bloc<NavigatorAction, dynamic>{

  NavigatorBloc({
    @required this.navigatorKey
  }): super(0);

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  Stream<dynamic> mapEventToState(NavigatorAction event) async* {
    try {
      final next = await event.go(navigatorKey?.currentState);
      if (next != null) add(next);
      yield true;
    } catch (e, stacktrace) {
      print("NavigatorBloc.mapEventToState.EXCEPTION: $e\n$stacktrace");
    }
  }
}

