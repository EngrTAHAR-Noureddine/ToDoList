import 'package:flutter/material.dart';
import 'package:todolist/ModelView/login_model.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  @override
  Widget build(BuildContext context) {
    return LogInClass();
  }
}
