// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../../data/dataSource/auth_dataSource_impl.dart' as _i595;
import '../../../data/dataSource/home_dataSource_impl.dart' as _i781;
import '../../../data/repository/auth_repos_impl.dart' as _i870;
import '../../../data/repository/home_repos_impl.dart' as _i272;
import '../../../domain/repository/auth/auth_remote_dataSource.dart' as _i285;
import '../../../domain/repository/auth/auth_repos.dart' as _i180;
import '../../../domain/repository/home/home_remoteDataSource.dart' as _i963;
import '../../../domain/repository/home/home_repos.dart' as _i226;
import '../../../domain/UseCases/auth_useCase.dart' as _i105;
import '../../../domain/UseCases/get_courses_useCase.dart' as _i461;
import '../../../feature/auth/login/cubit/login_viewModel.dart' as _i1013;
import '../../../feature/home/cubit/home_view_model.dart' as _i658;
import '../apis/api_manager.dart' as _i669;

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
    gh.singleton<_i669.ApiManager>(() => _i669.ApiManager());
    gh.factory<_i963.HomeRemotedatasource>(
        () => _i781.HomeDatasourceImpl(apiManager: gh<_i669.ApiManager>()));
    gh.factory<_i285.AuthdataSource>(
        () => _i595.AuthDatasourceImpl(apiManager: gh<_i669.ApiManager>()));
    gh.factory<_i180.AuthRepos>(
        () => _i870.AuthReposImpl(authdataSource: gh<_i285.AuthdataSource>()));
    gh.factory<_i105.AuthUsecase>(
        () => _i105.AuthUsecase(authRepos: gh<_i180.AuthRepos>()));
    gh.factory<_i1013.LoginViewmodel>(
        () => _i1013.LoginViewmodel(loginUseCase: gh<_i105.AuthUsecase>()));
    gh.factory<_i226.HomeRepos>(() => _i272.HomeReposImpl(
        homeRemotedatasource: gh<_i963.HomeRemotedatasource>()));
    gh.factory<_i461.GetCoursesUsecase>(
        () => _i461.GetCoursesUsecase(homeRepos: gh<_i226.HomeRepos>()));
    gh.factory<_i658.HomeViewModel>(() =>
        _i658.HomeViewModel(getCoursesUsecase: gh<_i461.GetCoursesUsecase>()));
    return this;
  }
}
