import 'package:flutter/material.dart';
import 'package:todolist/Models/Data/data_variable.dart';
import 'package:todolist/Models/ProvidersClass/settings_provider.dart';
import 'package:todolist/View/home_view.dart';

class LogInClass extends StatefulWidget {
  const LogInClass({Key key}) : super(key: key);

  @override
  _LogInClassState createState() => _LogInClassState();
}

class _LogInClassState extends State<LogInClass> {

  @override
  Widget build(BuildContext context) {
    return  OrientationBuilder(builder: (context, orientation) {
      Variables().isLarge =  (orientation == Orientation.portrait);
      return SafeArea(
        child: Container(
          color:Theme.of(context).backgroundColor,
          alignment: Alignment.center,
          child: Container(
            height:(Variables().isLarge)?MediaQuery.of(context).size.height*0.5:MediaQuery.of(context).size.height*0.9,
            width: (Variables().isLarge)?MediaQuery.of(context).size.height*0.5:MediaQuery.of(context).size.height*0.9,
            decoration: BoxDecoration(
              color: Theme.of(context).backgroundColor,

            ),
            child: Stack(
               alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(color: Colors.black12,blurRadius: 2,spreadRadius: 5,offset: Offset(3,5)),

                      ]
                  ),
                  height:(Variables().isLarge)?MediaQuery.of(context).size.height*0.4:MediaQuery.of(context).size.height*0.8,
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    height:(Variables().isLarge)?MediaQuery.of(context).size.height*0.3:MediaQuery.of(context).size.height*0.7,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        color: Colors.blue,
                        height:(Variables().isLarge)?MediaQuery.of(context).size.height*0.15:MediaQuery.of(context).size.height*0.3,
                      child: MaterialButton(
                        color: (SettingsProvider().user.passWord!=null && SettingsProvider().user.passWord.isNotEmpty)?Colors.green:Colors.red,
                        child: Text("click"),
                        onPressed: (){
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (BuildContext context) => Home(),
                              fullscreenDialog: true,
                            ),
                          );
                        },
                      )

                      ),
                      Container(
                        color: Colors.blue,
                        height:(Variables().isLarge)?MediaQuery.of(context).size.height*0.1:MediaQuery.of(context).size.height*0.3,

                      )
                    ],
                  ),

                  ),

                ),
                Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.all(Radius.circular(500)),
                        border: Border.all(width: 2,color: Theme.of(context).backgroundColor,style: BorderStyle.solid)
                      ),

                      height:MediaQuery.of(context).size.height*0.2,
                      width: MediaQuery.of(context).size.height*0.2,

                    ))
              ],
            ),
          ),
        ),
      );});
  }
}
