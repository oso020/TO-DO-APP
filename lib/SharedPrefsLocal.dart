
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'model/user_model.dart';

class SharedPrefsLocal{
  static late SharedPreferences prefs;
  static init()async{
    prefs=await SharedPreferences.getInstance();
  }


 static saveData({required String key , required UserModel model})async{
     return await prefs.setString(key, jsonEncode(model.toFirestore()));

  }

  static UserModel? getData({required String key}) {
    String? jsonString = prefs.getString(key); // get the data as a string
    if (jsonString != null) {
      Map<String, dynamic> jsonData = jsonDecode(jsonString); // decode the JSON
      var model = UserModel.fromFireStore(jsonData); // convert it to the model
      return model;
    }
    return null; // return null if the key doesn't exist or data is not found
  }

}