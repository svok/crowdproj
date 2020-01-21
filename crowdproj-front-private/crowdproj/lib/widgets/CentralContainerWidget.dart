
import 'package:flutter/cupertino.dart';

class CentralContainerWidget extends StatelessWidget{

  CentralContainerWidget({@required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => Container(
    alignment: AlignmentDirectional(0, 0),
    child: Container(
      constraints: BoxConstraints(
        minWidth: 200,
        maxWidth: 500,
        minHeight: 150,
        maxHeight: 300,
      ),
      alignment: AlignmentDirectional(0, 0),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: child,
      ),
    ),
  );

}
