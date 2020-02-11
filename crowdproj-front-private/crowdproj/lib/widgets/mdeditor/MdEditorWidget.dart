import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MdEditorWidget extends StatefulWidget {
  MdEditorWidget({
    Key key,
    this.initialText = "",
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
  String text;

  @override
  void initState() {
    super.initState();
    text = widget.initialText ?? "";
  }

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
              onTap: (int index) {
                setState(() {});
              },
            ),
          ),
          Container(
            alignment: Alignment.topCenter,
//            constraints: BoxConstraints(
//                maxHeight: MediaQuery.of(context).size.height / 2,
//            ),
            height: 200,
            child: TabBarView(
              children: [
                Align(
                  alignment: Alignment.topCenter,
//                  height: 200,
//                  width: MediaQuery.of(context).size.width / 2,
                  child: TextFormField(
                    initialValue: text,
                    keyboardType: TextInputType.multiline,
                    minLines: widget.minLines,
                    maxLines: widget.maxLines,
                    showCursor: true,
                    onSaved: widget.onSaved,
                    onChanged: (String newValue) {
                      text = newValue;
                    },
                  ),
                ),
                Align(
//                  height: 250,
//                  width: MediaQuery.of(context).size.width / 2,
                  alignment: Alignment.topCenter,
                  child: Scrollbar(
//                    child: SingleChildScrollView(
                    child: Markdown(data: text),
//                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
