import 'package:flutter/material.dart';

class ActivitySpinner extends StatelessWidget {
  ActivitySpinner({
    Key key,
    this.child,
    this.isWaiting: true,
    this.opacity: 0.3,
  }) : super(key: key);

  final Widget child;
  final bool isWaiting;
  final double opacity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return (isWaiting ?? false) ? Stack(
      children: <Widget>[
        child,
        Container(
          color: Color.fromRGBO(0, 0, 0, opacity),
          alignment: Alignment.center,
          child: Column(
            children: [
              Expanded(child: Container()),
              CircularProgressIndicator(),
              SizedBox(height: 20,),
              ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  color: Color.fromRGBO(255, 255, 255, opacity),
                  child: Text(
                    "Loading ...",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.headline6,
                  ),
                ),
              ),
              Expanded(child: Container()),
            ],
          ),
        ),
      ],
    ) : child;
  }
}
