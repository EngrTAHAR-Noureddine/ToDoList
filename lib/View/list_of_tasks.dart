import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/ModelView/page_of_tasks.dart';
import 'package:todolist/Models/ProvidersClass/provider_class.dart';

class ListOfTasks extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderClass>(
      builder: (context, value, child) {
        return PageView.builder(
          itemCount: value.listWidgets.length,
          scrollDirection: Axis.horizontal,
          controller: value.controller,
          itemBuilder: (context, index){
            return PageOfTasks(category:value.listWidgets[index]);
          },
          onPageChanged: (index){
            if(index>0) if(value.listWidgets.length>2) value.removeWidget();
          },
        );
      },

    );
  }
}



/*
class ListOfTasks extends StatefulWidget {

  @override
  _ListOfTasksState createState() => _ListOfTasksState();
}

class _ListOfTasksState extends State<ListOfTasks> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderClass>(
      builder: (context, value, child) {
        return PageView.builder(
          itemCount: value.listWidgets.length,
          scrollDirection: Axis.horizontal,
          controller: value.controller,
          itemBuilder: (context, index){
            return PageOfTasks(category:value.listWidgets[index]);
          },
          onPageChanged: (index){
            if(index>0) if(value.listWidgets.length>2) value.removeWidget();
          },
        );
      },

    );
  }
}

 */