import 'package:flutter/material.dart';
import 'package:todolist/ModelView/category_layout.dart';


class CategoryLayout extends StatefulWidget {


  @override
  _CategoryLayoutState createState() => _CategoryLayoutState();
}

class _CategoryLayoutState extends State<CategoryLayout> {




  @override
  Widget build(BuildContext context) {

    return CategoryBuilder();
  }
}
