import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GridWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Grid Demo'),
      ),
      body: new GridView.count(
        crossAxisCount: 4,
        children: new List<Widget>.generate(16, (index) {
          return new GridTile(
            child: new Card(
              color: Colors.blue.shade200,
              child: new Center(
                child: FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: new Text('tile $index'),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
