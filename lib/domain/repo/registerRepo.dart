import 'package:dartz/dartz.dart';
import 'package:to_do_app/domain/entites/RegisterResponseEntity.dart';
import 'package:to_do_app/domain/faluires.dart';

abstract class RegisterRepo {
  Future<Either<Failures, RegisterResponseEntity>> register(String name,
      String email, String password, String rPassword, String phone);
}
