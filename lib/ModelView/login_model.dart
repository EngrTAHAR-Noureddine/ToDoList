import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/Models/Data/data_variable.dart';
import 'package:todolist/Models/ProvidersClass/login_provider.dart';





class LogInClass extends StatelessWidget {




  @override
  Widget build(BuildContext context) {
    return Consumer<LogInProvider>(
        builder: (context, value, child) {
          return OrientationBuilder(
        builder: (context, orientation) {
                 Variables().isLarge =  (orientation == Orientation.portrait);
                 LogInProvider().setVariables(Variables().isLarge,context);
                 return Scaffold(
                      resizeToAvoidBottomInset: false,
                      body: Container(
                                        color:Colors.white,
                                        alignment: Alignment.center,

                                        child: Container(
                                          height:(Variables().isLarge)?LogInProvider().side*0.5:LogInProvider().side*0.8,
                                          width: (Variables().isLarge)?LogInProvider().side*0.5:LogInProvider().side*0.8,
                                          decoration: BoxDecoration( color: Colors.white,),
                                          margin: EdgeInsets.all(20),
                                          alignment: Alignment.bottomCenter,
                                          child: Stack(

                                            alignment: Alignment.bottomCenter,
                                            children: [
                                              ///************************************** Field Text ******************
                                              Container(
                                                decoration: BoxDecoration(
                                                    color: Color(0xFFF4F6FD),
                                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                                    border: Border.all(color: Color(0xFF2643C4),style: BorderStyle.solid,width: 2),
                                                    boxShadow: [
                                                      BoxShadow(color: Colors.black12,blurRadius: 2,spreadRadius: 5,offset: Offset(3,5)),

                                                    ]
                                                ),
                                                height:(Variables().isLarge)?LogInProvider().side*0.4:LogInProvider().side*0.7,
                                                alignment: Alignment.bottomCenter,
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Color(0xFFF4F6FD),
                                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                                  ),
                                                  height:(Variables().isLarge)?LogInProvider().side*0.3:LogInProvider().side*0.6,
                                                  child:Form(
                                                  key: LogInProvider().formKey,
                                                  child: SingleChildScrollView(
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [

                                                                  LogInProvider().inputPassword(context),

                                                                  LogInProvider().buttonLogIn(context)
                                                                ],
                                                              ),
                                                            ),
                                                  )

                                                ),

                                              ),


                                              ///******************************************************************************
                                              /*
                                              * LOGO
                                              * */
                                              LogInProvider().logPicture(context)
                                            ],
                                          ),
                                        ),
                                      ),
                            );
        });
        });
  }
}
