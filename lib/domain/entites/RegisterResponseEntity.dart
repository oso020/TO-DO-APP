/// message : "success"
/// user : {"name":"mohamed","email":"mohamedosman12321@gmail.com","role":"user"}
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2ZDFlZTE3NTI4ZGZlZTA0MDc1OGZmZiIsIm5hbWUiOiJtb2hhbWVkIiwicm9sZSI6InVzZXIiLCJpYXQiOjE3MjUwMzQwMDgsImV4cCI6MTczMjgxMDAwOH0.CGlGXVyzcOyGt5eyvW0gKIGveBfvcezt7B3RZhFS2Xg"

class RegisterResponseEntity {
  RegisterResponseEntity({
    this.message,
    this.user,
    this.token,
    this.statusMsg
  });

  String? message;
  UserEntity? user;
  String? token;
  String ?statusMsg;
}

/// name : "mohamed"
/// email : "mohamedosman12321@gmail.com"
/// role : "user"

class UserEntity {
  UserEntity({
    this.name,
    this.email,
  });

  String? name;
  String? email;

}
