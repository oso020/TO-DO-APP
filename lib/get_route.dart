import 'package:flutter/material.dart';
import 'package:to_do_app/Home/home_screen.dart';

import 'Home/login/login_screen.dart';
import 'Home/register/register_screen.dart';
import 'Home/to_do_list/change_detiles_task_screen.dart';

class RouteApp{

  static Route<dynamic> getRoute(RouteSettings settings){
    switch(settings.name){
      case Home.routeName:
      return  MaterialPageRoute(builder: (context) => Home(),);
      case ChangeDetilesTaskScreen.routeName:
        return  MaterialPageRoute(builder: (context) => ChangeDetilesTaskScreen(),);
      case LoginScreen.routeName:
        return  MaterialPageRoute(builder: (context) => LoginScreen(),);
      case RegisterScreen.routeName:
        return  MaterialPageRoute(builder: (context) => RegisterScreen(),);

      default:
        return   MaterialPageRoute(builder: (context) => LoginScreen(),);
    }


  }


}