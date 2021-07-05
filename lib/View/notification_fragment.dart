import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/Models/ProvidersClass/notification_provider.dart';

class NotificationView extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Consumer<NotificationProvider>(
        builder: (context, value, child){

          return Scaffold(
                  appBar: AppBar(title: Text("TAHAR"),),
                  body: Container(color: Colors.white, child: Text(value.getNumber().toString()),),
                );
        });
  }
}
