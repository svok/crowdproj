import 'package:bloc/bloc.dart';

import 'NavigatorAction.dart';

class NavigatorBloc extends Bloc<NavigatorAction, dynamic>{

  @override
  dynamic get initialState => NavigatorAction;

  @override
  Stream<dynamic> mapEventToState(NavigatorAction event) async* {
    print("NAVIGATOR mapEventToState for ${event.runtimeType}");
    event.go();
    yield true;
  }
}

