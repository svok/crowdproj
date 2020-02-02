import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import 'NavigatorAction.dart';

class NavigatorBloc extends Bloc<NavigatorAction, dynamic>{

  NavigatorBloc({
    @required this.navigatorKey
  }): super();

  final GlobalKey<NavigatorState> navigatorKey;

  @override
  dynamic get initialState => 0;

  @override
  Stream<dynamic> mapEventToState(NavigatorAction event) async* {
    final next = await event.go(navigatorKey?.currentState);
    if (next != null) add(next);
    yield true;
  }
}

