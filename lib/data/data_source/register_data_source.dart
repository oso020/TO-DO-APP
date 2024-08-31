import 'package:dartz/dartz.dart';

import '../../domain/entites/RegisterResponseEntity.dart';
import '../../domain/faluires.dart';

abstract class RegisterDataSource{
  Future<Either<Failures, RegisterResponseEntity>> register(String name,
      String email, String password, String rPassword, String phone);
}