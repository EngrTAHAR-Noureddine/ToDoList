import 'package:flutter/material.dart';
import 'package:todolist/ModelView/login_model.dart';
import 'package:todolist/Models/Data/user_model.dart';
import 'package:todolist/Models/ProvidersClass/provider_class.dart';
import 'package:todolist/Models/ProvidersClass/settings_provider.dart';

class LogIn extends StatelessWidget {

  Future<bool> getIt()async{
    User user = await SettingsProvider().getUser();
    await ProviderClass().setAppMod(user);

    return true;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getIt(),
        builder: (context,snapshot){
          if(snapshot.hasData) {return LogInClass();} else {return Container(color: Color(0xFFF4F6FD),);}
        }

    );
  }
}


/*
class LogIn extends StatefulWidget {
  const LogIn({Key key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  Future<bool> getIt()async{
    User user = await SettingsProvider().getUser();
    await ProviderClass().setAppMod(user);

    return true;
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getIt(),
        builder: (context,snapshot){
        if(snapshot.hasData) {return LogInClass();} else {return Container(color: Colors.white,);}
      }

        );
  }
}
*/
