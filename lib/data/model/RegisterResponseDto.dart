import 'package:to_do_app/domain/entites/RegisterResponseEntity.dart';

/// message : "success"
/// user : {"name":"mohamed","email":"mohamedosman12321@gmail.com","role":"user"}
/// token : "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjY2ZDFlZTE3NTI4ZGZlZTA0MDc1OGZmZiIsIm5hbWUiOiJtb2hhbWVkIiwicm9sZSI6InVzZXIiLCJpYXQiOjE3MjUwMzQwMDgsImV4cCI6MTczMjgxMDAwOH0.CGlGXVyzcOyGt5eyvW0gKIGveBfvcezt7B3RZhFS2Xg"

class RegisterResponseDto extends RegisterResponseEntity {
  RegisterResponseDto({
      super.message,
    super.user,
    super.statusMsg,
    super.token,});

  RegisterResponseDto.fromJson(dynamic json) {
    message = json['message'];
    statusMsg = json['statusMsg'];
    user = json['user'] != null ? UserDto.fromJson(json['user']) : null;
    token = json['token'];
  }




}

/// name : "mohamed"
/// email : "mohamedosman12321@gmail.com"
/// role : "user"

class UserDto extends UserEntity {
  UserDto({
    super.name,
    super.email,
    this.role,});

  UserDto.fromJson(dynamic json) {
    name = json['name'];
    email = json['email'];
    role = json['role'];
  }

  String? role;



}