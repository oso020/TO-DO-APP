import 'package:flutter/material.dart';
import 'package:to_do_app/model/user_model.dart';

class AuthUserProvider extends ChangeNotifier{



  UserModel? currentUser;

  void updateUser(UserModel newUser){

    currentUser = newUser ;

    notifyListeners();
  }

}