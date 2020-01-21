import 'package:flutter/material.dart';

import 'EmptyApp.dart';

class ActivitySpinner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return EmptyApp(
      child: Container(
        color: Color.fromRGBO(0, 0, 0, 0.2),
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(child: Container()),
            Image.asset(
              'assets/img/activity-spinner.gif',
              fit: BoxFit.scaleDown,
              width: 84.0,
              height: 84.0,
            ),
            Text(
              'Loading...',
              textAlign: TextAlign.center,
              style: theme.textTheme.title,
            ),
            Expanded(child: Container()),
          ],
        ),
      ),
    );
  }
}
