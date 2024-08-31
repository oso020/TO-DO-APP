import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:to_do_app/data/data_source/register_data_source.dart';

import 'package:to_do_app/domain/entites/RegisterResponseEntity.dart';

import 'package:to_do_app/domain/faluires.dart';

import '../../domain/repo/registerRepo.dart';

@Injectable(as: RegisterRepo)
class RegisterRepoImpl extends RegisterRepo {
  RegisterDataSource registerDataSource;
  RegisterRepoImpl({required this.registerDataSource});

  @override
  Future<Either<Failures, RegisterResponseEntity>> register(String name,
      String email, String password, String rPassword, String phone) async {
    var response = await registerDataSource.register(
        name, email, password, rPassword, phone);
    return response.fold(
      (error) => Left(error),
      (response) => Right(response),
    );
  }
}
