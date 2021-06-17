import 'package:flutter/material.dart';
import 'package:todolist/DataBase/database.dart';
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



 Widget getIcon(){
    switch(this.task.status){
      case "Important": /*C00000*/
        return Icon(Icons.circle_rounded,color: Color(0xFFC00000),);
        break;
      case "Less important": /* ff4500 */
        return Icon(Icons.circle_rounded,color: Color(0xFFFF4500));
              break;
      case "Finished"://00B98C
        return Icon(Icons.check_circle_outline_sharp,color: Color(0xFF6D6E70));
        break;
      case "Voluntary": /* 6D6E70 */
        return Icon(Icons.circle_rounded,color: Color(0xFF6D6E70));
          break;
      default : /* In progress  0269CA */
        return Icon(Icons.circle_rounded,color: Color(0xFF0269CA));
        break;

    }
  }
}

class _TodayTasksState extends State<TodayTasks> {

  Future<List<Task>> getListTaskToday()async{

    DateTime dateNow = DateTime.now();
    String date = dateNow.day.toString()+"/"+dateNow.month.toString()+"/"+dateNow.year.toString();
    List<Task> list = await DBProvider.db.getByDate(date, date);

   // setState(() {});
    return (list.isEmpty)?[]:list;
  }

  Widget panel(Item item){
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            color: Colors.white54
          ),
          child: ListTile(
            leading: item.getIcon(),
            title: Text(item.task.task, style: TextStyle(color: Colors.black),),
            trailing:Icon( (item.isExpanded)?Icons.keyboard_arrow_down_outlined:Icons.keyboard_arrow_up_outlined, color: Colors.black,),
          onTap: (){
             setState(() {
               print("inside panel : "+item.task.task+" => "+item.isExpanded.toString());
               item.isExpanded = !item.isExpanded;

               print("inside panel : "+item.task.task+" => "+item.isExpanded.toString());
             });
          },
          ),
        ),
        (item.isExpanded)?
        Container(child: ListTile(
          title: Text("Note : " ,style: TextStyle(color: Colors.red),),
          subtitle: Container(
            height: 120,
            child: Text((item.task.note.isEmpty)?"add note ...!": item.task.note),
          ),
        ))
            :Container(),
      ],
    );
  }



  Widget pageViewToDay(){
    return Container(
      child: FutureBuilder(
          future: getListTaskToday(),
          builder: (context,AsyncSnapshot snapshot){
            if(snapshot.hasData) {
              List<Task> list = snapshot.data;
              List<Item> items = List<Item>.generate(list.length, (int index) {
                return Item(list[index]);
              });
              print(items);

              return ListView(
                children: items.map((item){
                  return panel(item);
                }).toList(),
              );

            }

              return Center(child: Text("Take a break now you have no tasks"),);
          }),
    );
  }



  @override
  Widget build(BuildContext context) {



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
