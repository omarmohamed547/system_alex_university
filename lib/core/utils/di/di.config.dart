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
import '../../../data/dataSource/examTable_dataSource_impl.dart' as _i524;
import '../../../data/dataSource/home_dataSource_impl.dart' as _i781;
import '../../../data/dataSource/performance_dataSource_impl.dart' as _i481;
import '../../../data/dataSource/profile_picture_dataSource_impl.dart' as _i92;
import '../../../data/dataSource/register_stu_dataSource.dart' as _i11;
import '../../../data/dataSource/timeTable_dataSource_Impl.dart' as _i1030;
import '../../../data/repository/auth_repos_impl.dart' as _i870;
import '../../../data/repository/examTable_repos_impl.dart' as _i946;
import '../../../data/repository/home_repos_impl.dart' as _i272;
import '../../../data/repository/performance_repos_impl.dart' as _i466;
import '../../../data/repository/profile_picture_repos_impl.dart' as _i473;
import '../../../data/repository/register_stu_repos.dart' as _i797;
import '../../../data/repository/time_table_repos_Impl.dart' as _i993;
import '../../../domain/repository/auth/auth_remote_dataSource.dart' as _i285;
import '../../../domain/repository/auth/auth_repos.dart' as _i180;
import '../../../domain/repository/examTable/ExamTable_dataSource.dart' as _i34;
import '../../../domain/repository/examTable/ExamTable_repos.dart' as _i726;
import '../../../domain/repository/home_doc/home_remoteDataSource.dart'
    as _i725;
import '../../../domain/repository/home_doc/home_repos.dart' as _i294;
import '../../../domain/repository/home_stu/time_table_dataSource.dart'
    as _i1017;
import '../../../domain/repository/home_stu/time_table_repos.dart' as _i473;
import '../../../domain/repository/performance/performance_dataSource.dart'
    as _i57;
import '../../../domain/repository/performance/performance_repos.dart' as _i522;
import '../../../domain/repository/profilePicture/profile_picture_dataSource.dart'
    as _i505;
import '../../../domain/repository/profilePicture/profile_picture_repos.dart'
    as _i840;
import '../../../domain/repository/register_student/registerStu_dataSource.dart'
    as _i235;
import '../../../domain/repository/register_student/registerStu_repos.dart'
    as _i165;
import '../../../domain/UseCases/auth_useCase.dart' as _i105;
import '../../../domain/UseCases/drop_cource_useCase.dart' as _i463;
import '../../../domain/UseCases/drop_secUseCase.dart' as _i5;
import '../../../domain/UseCases/get_courses_useCase.dart' as _i461;
import '../../../domain/UseCases/get_examTable.dart' as _i396;
import '../../../domain/UseCases/get_performance_useCase.dart' as _i1066;
import '../../../domain/UseCases/get_profilePicture.dart' as _i514;
import '../../../domain/UseCases/get_time_table_useCase.dart' as _i562;
import '../../../domain/UseCases/getAvliableCourseStudent.dart' as _i1008;
import '../../../domain/UseCases/register_course_useCase.dart' as _i15;
import '../../../domain/UseCases/registerSectionUseCase.dart' as _i722;
import '../../../feature/auth/login/cubit/login_viewModel.dart' as _i1013;
import '../../../feature/ExamTable/cubit/examTableViesModel.dart' as _i235;
import '../../../feature/home/cubit/home_view_model.dart' as _i658;
import '../../../feature/performance/cubit/performance_view_model.dart'
    as _i539;
import '../../../feature/profile/cubit/profile_view_model.dart' as _i356;
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
    gh.factory<_i57.PerformanceDatasource>(() =>
        _i481.PerformanceDatasourceImpl(apiManager: gh<_i669.ApiManager>()));
    gh.factory<_i1017.TimeTableDatasource>(() =>
        _i1030.TimetableDatasourceImpl(apiManager: gh<_i669.ApiManager>()));
    gh.factory<_i285.AuthdataSource>(
        () => _i595.AuthDatasourceImpl(apiManager: gh<_i669.ApiManager>()));
    gh.factory<_i34.ExamtableDatasource>(() =>
        _i524.TimetableDatasourceImpl(apiManager: gh<_i669.ApiManager>()));
    gh.factory<_i725.HomeRemotedatasource>(
        () => _i781.HomeDatasourceImpl(apiManager: gh<_i669.ApiManager>()));
    gh.factory<_i235.RegistertuDatasource>(() =>
        _i11.RegisterStuDatasourceimp(apiManager: gh<_i669.ApiManager>()));
    gh.factory<_i180.AuthRepos>(
        () => _i870.AuthReposImpl(authdataSource: gh<_i285.AuthdataSource>()));
    gh.factory<_i505.ProfilePictureDatasource>(() =>
        _i92.ProfilePictureDatasourceImpl(apiManager: gh<_i669.ApiManager>()));
    gh.factory<_i105.AuthUsecase>(
        () => _i105.AuthUsecase(authRepos: gh<_i180.AuthRepos>()));
    gh.factory<_i522.PerformanceRepos>(() => _i466.PerformanceReposImpl(
        performanceDatasource: gh<_i57.PerformanceDatasource>()));
    gh.factory<_i1013.LoginViewmodel>(
        () => _i1013.LoginViewmodel(loginUseCase: gh<_i105.AuthUsecase>()));
    gh.factory<_i473.TimeTableRepos>(() => _i993.TimeTableReposImpl(
        tableDatasource: gh<_i1017.TimeTableDatasource>()));
    gh.factory<_i1066.GetPerformanceUsecase>(() => _i1066.GetPerformanceUsecase(
        performanceRepos: gh<_i522.PerformanceRepos>()));
    gh.factory<_i726.ExamtableRepos>(() => _i946.TimeTableReposImpl(
        examtableDatasource: gh<_i34.ExamtableDatasource>()));
    gh.factory<_i165.RegisterstudentRepos>(() => _i797.RegisterStuReposimpl(
        registerStuDatasource: gh<_i235.RegistertuDatasource>()));
    gh.factory<_i840.ProfilePictureRepos>(() => _i473.ProfilePictureReposImpl(
        profilePictureDatasource: gh<_i505.ProfilePictureDatasource>()));
    gh.factory<_i294.HomeRepos>(() => _i272.HomeReposImpl(
        homeRemotedatasource: gh<_i725.HomeRemotedatasource>()));
    gh.factory<_i396.GetExamTableUsecase>(() =>
        _i396.GetExamTableUsecase(examtableRepos: gh<_i726.ExamtableRepos>()));
    gh.factory<_i539.PerformanceViewModel>(() => _i539.PerformanceViewModel(
        getPerformanceUsecase: gh<_i1066.GetPerformanceUsecase>()));
    gh.factory<_i562.GetTimeTableUsecase>(() =>
        _i562.GetTimeTableUsecase(timeTableRepos: gh<_i473.TimeTableRepos>()));
    gh.factory<_i461.GetCoursesUsecase>(
        () => _i461.GetCoursesUsecase(homeRepos: gh<_i294.HomeRepos>()));
    gh.factory<_i514.GetProfilepictureUseCase>(() =>
        _i514.GetProfilepictureUseCase(
            profilePictureRepos: gh<_i840.ProfilePictureRepos>()));
    gh.factory<_i1008.GetavliablecoursestudentUseCase>(() =>
        _i1008.GetavliablecoursestudentUseCase(
            registerstudentRepos: gh<_i165.RegisterstudentRepos>()));
    gh.factory<_i15.RegisterCourseUsecase>(() => _i15.RegisterCourseUsecase(
        registerstudentRepos: gh<_i165.RegisterstudentRepos>()));
    gh.factory<_i463.DropCourceUsecase>(() => _i463.DropCourceUsecase(
        registerstudentRepos: gh<_i165.RegisterstudentRepos>()));
    gh.factory<_i722.RegisterSectionUsecase>(() => _i722.RegisterSectionUsecase(
        registerstudentRepos: gh<_i165.RegisterstudentRepos>()));
    gh.factory<_i5.DropSecusecase>(() => _i5.DropSecusecase(
        registerstudentRepos: gh<_i165.RegisterstudentRepos>()));
    gh.factory<_i235.Examtableviesmodel>(() => _i235.Examtableviesmodel(
        getExamTableUsecase: gh<_i396.GetExamTableUsecase>()));
    gh.factory<_i356.ProfileViewModel>(() => _i356.ProfileViewModel(
        getProfilepictureUseCase: gh<_i514.GetProfilepictureUseCase>()));
    gh.factory<_i658.HomeViewModel>(() => _i658.HomeViewModel(
          getCoursesUsecase: gh<_i461.GetCoursesUsecase>(),
          getTimeTableUsecase: gh<_i562.GetTimeTableUsecase>(),
        ));
    gh.factory<_i80.RegistirationnViewModel>(() => _i80.RegistirationnViewModel(
          getavliablecoursestudentUseCase:
              gh<_i1008.GetavliablecoursestudentUseCase>(),
          dropSecusecase: gh<_i5.DropSecusecase>(),
          registerSectionUsecase: gh<_i722.RegisterSectionUsecase>(),
          dropCourceUsecase: gh<_i463.DropCourceUsecase>(),
          registerCourseUsecase: gh<_i15.RegisterCourseUsecase>(),
        ));
    return this;
  }
}
