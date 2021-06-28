import 'package:flutter/material.dart';
import 'package:todolist/ModelView/category_model.dart';


class CategoryView extends StatefulWidget {


  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {




  @override
  Widget build(BuildContext context) {

    return CategoryBuilder();
  }
}
