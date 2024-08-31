import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:to_do_app/data/api_manger.dart';
import 'package:to_do_app/data/data_source/register_data_source.dart';
import 'package:to_do_app/domain/faluires.dart';

import '../../model/RegisterResponseDto.dart';
@Injectable(as:RegisterDataSource)
class RegisterDataSourceImpl extends RegisterDataSource {
  ApiManger apiManger;
  RegisterDataSourceImpl({required this.apiManger});

  @override

  Future<Either<Failures, RegisterResponseDto>> register(String name,
      String email, String password, String rePassword, String phone) async {
    try {
      var checkResult = await Connectivity().checkConnectivity();
      if (checkResult.contains(ConnectivityResult.wifi) ||
          checkResult.contains(ConnectivityResult.mobile) ) {
        // internet


        var response = await apiManger.postData(
            body: {
              "name": name,
              "email": email,
              "password": password,
              "rePassword": rePassword,
              "phone": phone
            });

        var registerResponse = RegisterResponseDto.fromJson(response.data);

        if(registerResponse.statusMsg == 'fail'){
          print('inside if : ${registerResponse.statusMsg}');
          return Left(ServerError(errorMessage: registerResponse.message!));
          /// error
        }
        if (response.statusCode! >= 200 && response.statusCode! < 300) {
          /// success
          return Right(registerResponse);
        }else{
          return Left(ServerError(errorMessage: registerResponse.message!));
        }
      } else {
        /// no internet connection
        return Left(NetworkError(
            errorMessage: 'No Internet Connection, Please'
                'check internet connection'));
      }
    }catch(e){

      return Left(Failures(errorMessage: e.toString()));
    }
  }
}
