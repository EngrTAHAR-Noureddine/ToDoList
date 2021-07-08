import 'package:flutter/material.dart';
import 'dart:math'as math;

import 'package:todolist/Models/ProvidersClass/settings_provider.dart';
import 'package:todolist/View/home_view.dart';

class LogInProvider extends ChangeNotifier{

  static final LogInProvider _singleton = LogInProvider._internal();
  factory LogInProvider() {
    return _singleton;
  }
  LogInProvider._internal();
  
  bool isBig;
  double side;
  setVariables(bool big ,context){
    this.isBig=big;
    this.side = MediaQuery.of(context).size.height;
  }
  
  TextEditingController passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  
  inputPassword(context){
    return Container(
      color:Color(0xFFF4F6FD),
      height:(this.isBig)?this.side*0.15:this.side*0.3,
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: 10, right: 10,),
      child: TextFormField(

        // focusNode: currentFocus,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter some text';
          }else if(SettingsProvider().user.passWord == this.passwordController.text){
            return null;
          }else{
              return 'Password is incorrect';
          }

        },
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 14,color: Theme.of(context).floatingActionButtonTheme.backgroundColor ),
        maxLines: 1,
        maxLength: 100,
        showCursor: true,
        obscureText: true,
        controller: passwordController,
        autofocus: true,
        minLines: 1,
        keyboardType: TextInputType.text,

        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          alignLabelWithHint: false,
          labelText: null,
          prefixIcon: Icon(Icons.lock,color: Color(0xFF2643C4)),
          counterStyle: TextStyle(
            height: double.minPositive,
          ),
          counterText: "",
          focusedBorder:OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),

            borderSide: BorderSide(
              color: Color(0xFF2643C4),
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),

            borderSide: BorderSide(
              color: Theme.of(context).errorColor,
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),

            borderSide: BorderSide(
              color: Theme.of(context).errorColor,
              width: 1,
              style: BorderStyle.solid,
            ),
          ),
          hintText: "Enter password",
          hintStyle: TextStyle(color: Color(0xFFB8B8B8)),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),

            borderSide: BorderSide(
              color: Color(0xFF2643C4),
              width: 1,
              style: BorderStyle.solid,
            ),
          ),

        ),
        toolbarOptions: ToolbarOptions(
          cut: true,
          copy: true,
          selectAll: true,
          paste: true,
        ),
      ),

    );
  }
  
  buttonLogIn(context){
    return  Container(
      color:Colors.transparent,
      height:(this.isBig)?this.side*0.05:this.side*0.1,

      padding: EdgeInsets.all(0),
      child: MaterialButton(
        color: Color(0xFF2643C4),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side:  BorderSide(
                width: 0,
                color: Colors.white,
                style: BorderStyle.solid)

        ),
        padding: EdgeInsets.all(0),
        height: 20,
        child: Text("Log In" ,style: TextStyle(color: Colors.white),),
        onPressed: (){
    if (this.formKey.currentState.validate()) {
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => Home(),
            fullscreenDialog: true,
          ),
        );

    }
        },
      ),
    );
  }
  
  
  logPicture(context){
    return Align(
        alignment: Alignment.topCenter,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.all(Radius.circular(500)),
             // border: Border.all(width: 2,color: Theme.of(context).backgroundColor,style: BorderStyle.solid)
          ),
        //  alignment: Alignment.center,
          height:this.side*0.2,
          width: this.side*0.2,

              child: Stack(
                alignment:  Alignment.center,
                children: [
                  Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(500)),
                      ),

                      height:this.side*0.2,
                      width: this.side*0.2,
                      alignment: Alignment.bottomCenter,
                      child: MyArc(diameter: this.side*0.2)
                  ),
                        Container(
                        decoration: BoxDecoration(
                        color: Color(0xFFF4F6FD),
                          borderRadius: BorderRadius.all(Radius.circular(500)),
                            boxShadow: [
                              BoxShadow(color: Colors.black12,blurRadius: 2,spreadRadius: 5,offset: Offset(3,5)),

                            ],
                          border: Border.all(color: Color(0xFF2643C4),style: BorderStyle.solid,width: 4),
                        ),

                    height:this.side*0.18,
                    width: this.side*0.18,
                          alignment: Alignment.center,
                          child: Image.asset("assets/images/ICON.png" ,width: this.side*0.13,height: this.side*0.13,),
                        ),

                ],
              ),
        ));
  }
  
}


class MyArc extends StatelessWidget {
  final double diameter;

  const MyArc({Key key, this.diameter = 200}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: MyPainter(),
      size: Size(diameter, diameter),
    );
  }
}

// This is the Painter class
class MyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color =Color(0xFF2643C4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;


    canvas.drawArc(
      Rect.fromCenter(
        center: Offset(size.height / 2, size.width / 2),
        height: size.height,
        width: size.width,
      ),
      math.pi,
      -math.pi,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}