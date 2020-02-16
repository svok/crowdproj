import 'TeamsBloc.dart';
import 'TeamsEvent.dart';

class TeamsEventReadNext extends TeamsEvent{
  TeamsEventReadNext({
    this.amount: TeamsBloc.BATCH_SIZE,
  }) : super();

  int amount;
}
