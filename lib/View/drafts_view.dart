import 'package:flutter/material.dart';
import 'package:todolist/ModelView/draft_model.dart';


class DraftsView extends StatefulWidget {
  const DraftsView({Key key}) : super(key: key);

  @override
  _DraftsViewState createState() => _DraftsViewState();
}

class _DraftsViewState extends State<DraftsView> {
  @override
  Widget build(BuildContext context) {
    return DraftLists();
  }
}
