import 'package:flutter/material.dart';
import 'package:todolist/ModelView/list_of_drafts.dart';


class PageOfDrafts extends StatefulWidget {
  const PageOfDrafts({Key key}) : super(key: key);

  @override
  _PageOfDraftsState createState() => _PageOfDraftsState();
}

class _PageOfDraftsState extends State<PageOfDrafts> {
  @override
  Widget build(BuildContext context) {
    return ListOfDrafts();
  }
}