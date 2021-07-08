import 'package:flutter/material.dart';
import 'package:todolist/ModelView/login_model.dart';
import 'package:todolist/Models/Data/user_model.dart';
import 'package:todolist/Models/ProvidersClass/provider_class.dart';
import 'package:todolist/Models/ProvidersClass/settings_provider.dart';
import 'package:todolist/View/home_view.dart';

class LogIn extends StatelessWidget {

  Future<bool> getIt()async{
    User user = await SettingsProvider().getUser();
    await ProviderClass().setAppMod(user);
    if(user!=null){
      if(user.passWord!=null && user.passWord.isNotEmpty){
        return true;
      }else return false;
    }else throw("user is null");
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getIt(),
        builder: (context,snapshot){
          print(snapshot.hasData);
          print(snapshot.data);
          print(snapshot.hasError);
          print(snapshot.error);
          if(snapshot.hasData) {

            if(snapshot.data==true){
              return LogInClass();
            }
            else{
              return Home();
            }

          } else {
            return Container(color: Color(0xFFF4F6FD),);

          }
        }

    );
  }
}


