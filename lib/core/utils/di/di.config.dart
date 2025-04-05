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
import '../../../data/dataSource/register_stu_dataSource.dart' as _i11;
import '../../../data/repository/auth_repos_impl.dart' as _i870;
import '../../../data/repository/home_repos_impl.dart' as _i272;
import '../../../data/repository/register_stu_repos.dart' as _i797;
import '../../../domain/repository/auth/auth_remote_dataSource.dart' as _i285;
import '../../../domain/repository/auth/auth_repos.dart' as _i180;
import '../../../domain/repository/home_doc/home_remoteDataSource.dart'
    as _i725;
import '../../../domain/repository/home_doc/home_repos.dart' as _i294;
import '../../../domain/repository/register_student/registerStu_dataSource.dart'
    as _i235;
import '../../../domain/repository/register_student/registerStu_repos.dart'
    as _i165;
import '../../../domain/UseCases/auth_useCase.dart' as _i105;
import '../../../domain/UseCases/drop_cource_useCase.dart' as _i463;
import '../../../domain/UseCases/get_courses_useCase.dart' as _i461;
import '../../../domain/UseCases/getAvliableCourseStudent.dart' as _i1008;
import '../../../domain/UseCases/register_course_useCase.dart' as _i15;
import '../../../feature/auth/login/cubit/login_viewModel.dart' as _i1013;
import '../../../feature/home/cubit/home_view_model.dart' as _i658;
import '../../../feature/registiration/cubit/registiration_view_model.dart'
    as _i80;
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
    gh.factory<_i285.AuthdataSource>(
        () => _i595.AuthDatasourceImpl(apiManager: gh<_i669.ApiManager>()));
    gh.factory<_i725.HomeRemotedatasource>(
        () => _i781.HomeDatasourceImpl(apiManager: gh<_i669.ApiManager>()));
    gh.factory<_i235.RegistertuDatasource>(() =>
        _i11.RegisterStuDatasourceimp(apiManager: gh<_i669.ApiManager>()));
    gh.factory<_i180.AuthRepos>(
        () => _i870.AuthReposImpl(authdataSource: gh<_i285.AuthdataSource>()));
    gh.factory<_i105.AuthUsecase>(
        () => _i105.AuthUsecase(authRepos: gh<_i180.AuthRepos>()));
    gh.factory<_i1013.LoginViewmodel>(
        () => _i1013.LoginViewmodel(loginUseCase: gh<_i105.AuthUsecase>()));
    gh.factory<_i165.RegisterstudentRepos>(() => _i797.RegisterStuReposimpl(
        registerStuDatasource: gh<_i235.RegistertuDatasource>()));
    gh.factory<_i294.HomeRepos>(() => _i272.HomeReposImpl(
        homeRemotedatasource: gh<_i725.HomeRemotedatasource>()));
    gh.factory<_i461.GetCoursesUsecase>(
        () => _i461.GetCoursesUsecase(homeRepos: gh<_i294.HomeRepos>()));
    gh.factory<_i1008.GetavliablecoursestudentUseCase>(() =>
        _i1008.GetavliablecoursestudentUseCase(
            registerstudentRepos: gh<_i165.RegisterstudentRepos>()));
    gh.factory<_i15.RegisterCourseUsecase>(() => _i15.RegisterCourseUsecase(
        registerstudentRepos: gh<_i165.RegisterstudentRepos>()));
    gh.factory<_i463.DropCourceUsecase>(() => _i463.DropCourceUsecase(
        registerstudentRepos: gh<_i165.RegisterstudentRepos>()));
    gh.factory<_i658.HomeViewModel>(() =>
        _i658.HomeViewModel(getCoursesUsecase: gh<_i461.GetCoursesUsecase>()));
    gh.factory<_i80.RegistirationnViewModel>(() => _i80.RegistirationnViewModel(
          getavliablecoursestudentUseCase:
              gh<_i1008.GetavliablecoursestudentUseCase>(),
          dropCourceUsecase: gh<_i463.DropCourceUsecase>(),
          registerCourseUsecase: gh<_i15.RegisterCourseUsecase>(),
        ));
    return this;
  }
}
