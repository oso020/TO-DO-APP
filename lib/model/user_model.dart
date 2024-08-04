class UserModel{
  static const String user="user";
  String ?id;
  String ?email;
  String ?userName;

  UserModel({
    required this.id,
    required this.email,
    required this.userName,
});


  UserModel.fromFireStore(Map<String,dynamic> data):this(
    id: data["id"] as String,
    email: data["email"] as String,
    userName: data["userName"] as String,
  );

  Map<String,dynamic>toFirestore(){
    return {
      "id":id,
      "email":email,
      "userName":userName
    };
  }
}