import 'package:flutter/material.dart';
import 'package:todolist/DataBase/database.dart';
import 'package:todolist/Models/data_variable.dart';
import 'package:todolist/Models/task_model.dart';

class TodayTasks extends StatefulWidget {

  @override
  _TodayTasksState createState() => _TodayTasksState();
}

class Item{
Task task;
bool isExpanded;
  Item(Task task){
    this.task= task;
    this.isExpanded = false;
  }
 dynamic getColor(){
    switch(this.task.status){
      case "Important": /*C00000*/
        return Color(0xFFC00000);
        break;
      case "Less important": /* ff4500 */
        return Color(0xFFFF4500);
              break;
      case "Finished":
        return Color(0xFF00B98C);
        break;
      case "Voluntary": /* 6D6E70 */
        return Color(0xFF6D6E70);
          break;
      default : /* In progress  0269CA */
        return Color(0xFF0269CA);
        break;

    }
  }
}

class _TodayTasksState extends State<TodayTasks> {
  bool _isLarge;


  @override
  void initState() {

    _isLarge = Variables().isLarge;
  }
  @override
  Widget build(BuildContext context) {
    initState();
 Future<List<Task>> getListTaskToday()async{

    DateTime dateNow = DateTime.now();
 String date = dateNow.day.toString()+"/"+dateNow.month.toString()+"/"+dateNow.year.toString();
    List<Task> list = await DBProvider.db.getByDate(date, date);

  setState(() {});
   return (list.isEmpty)?[]:list;
 }
    Widget pageViewToDay(){
      return FutureBuilder(
          future: getListTaskToday(),
          builder: (context,AsyncSnapshot snapshot){
            if(snapshot.hasData){
              List<Task> list = snapshot.data;
           List<Item> items  = List<Item>.generate(list.length, (int index) {
                return Item(list[index]);
              });

            return ExpansionPanelList(
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  items[index].isExpanded = !isExpanded;
                });
              },
              children: items.map<ExpansionPanel>((Item item) {
                return ExpansionPanel(
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      title: Text(item.task.task),
                    );
                  },
                  body: ListTile(
                      title: Text(item.task.note),
                      subtitle: const Text('To delete this panel, tap the trash can icon'),
                      trailing: const Icon(Icons.delete),
                      onTap: () {
                        setState(() {
                          items.removeWhere((Item currentItem) => item == currentItem);
                        });
                      }
                  ),
                  isExpanded: item.isExpanded,
                );
              }).toList(),
            );

          }else return Container();

          });
    }

    return PageView(
      children: <Widget>[
        pageViewToDay(),
        Container(
          color: Colors.cyan,
        ),

      ],
    );
  }
}
