// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../data/api_manger.dart' as _i259;
import '../data/data_source/register_data_source.dart' as _i272;
import '../data/data_source/remote/register_data_source_impl.dart' as _i511;
import '../data/rep_impl/register_repo_impl.dart' as _i831;
import '../domain/repo/registerRepo.dart' as _i15;
import '../domain/use_cases/use_case_register.dart' as _i615;
import '../Home/register/cubit/register_view_model.dart' as _i489;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i259.ApiManger>(() => _i259.ApiManger());
    gh.factory<_i272.RegisterDataSource>(
        () => _i511.RegisterDataSourceImpl(apiManger: gh<_i259.ApiManger>()));
    gh.factory<_i15.RegisterRepo>(() => _i831.RegisterRepoImpl(
        registerDataSource: gh<_i272.RegisterDataSource>()));
    gh.factory<_i615.RegisterUseCase>(
        () => _i615.RegisterUseCase(registerRepo: gh<_i15.RegisterRepo>()));
    gh.factory<_i489.RegisterViewModel>(() =>
        _i489.RegisterViewModel(registerUseCase: gh<_i615.RegisterUseCase>()));
    return this;
  }
}
