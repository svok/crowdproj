import 'package:flutter/material.dart';

class RadioItemWidget<T> extends StatelessWidget {
  RadioItemWidget({
    Key key,
    this.title,
    this.value,
    this.groupValue,
    this.onChanged,
  }) : super(key: key);

  final Widget title;
  final T value;
  final T groupValue;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) =>
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Radio(value: value, groupValue: groupValue, onChanged: onChanged),
            title,
          ],
        );
}
