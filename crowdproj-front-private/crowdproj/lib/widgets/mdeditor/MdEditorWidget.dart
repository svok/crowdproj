import 'package:flutter/material.dart';

class MdEditorWidget extends StatefulWidget {
  MdEditorWidget({
    Key key,
    this.initialText,
    this.maxLines: 10,
    this.minLines: 3,
    this.onSaved,
  }) : super(key: key);

  final String initialText;
  final int minLines;
  final int maxLines;
  final FormFieldSetter<String> onSaved;

  @override
  _MdEditorWidgetState createState() => _MdEditorWidgetState();
}

class _MdEditorWidgetState extends State<MdEditorWidget> {
  @override
  Widget build(BuildContext context) {
    final themeActive = Theme.of(context).textTheme.headline6;
    final themeInactive = Theme.of(context).textTheme.caption;
    return DefaultTabController(
      length: 2,
      child: Column(
        children: <Widget>[
          Container(
            color: themeActive.backgroundColor,
            child: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: themeActive.color,
              unselectedLabelColor: themeInactive.color,
              tabs: [
                Tab(text: "Edit"),
                Tab(text: "View"),
              ],
            ),
          ),
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width,
              maxHeight: MediaQuery.of(context).size.height/2
            ),
            child: TabBarView(
              children: [
                Container(
                  height: 200,
                  width: MediaQuery.of(context).size.width/2,
                  child: TextFormField(
                    initialValue: widget.initialText,
                    keyboardType: TextInputType.multiline,
                    minLines: widget.minLines,
                    maxLines: widget.maxLines,
                    onSaved: widget.onSaved,
                  ),
                ),
                Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width/2,
                  child: SingleChildScrollView(),
                ),

//                TextFormField(
//                  initialValue: widget.initialText,
//                  keyboardType: TextInputType.multiline,
//                  minLines: widget.minLines,
//                  maxLines: widget.maxLines,
//                  onSaved: widget.onSaved,
//                ),
//                Icon(Icons.directions_transit),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
