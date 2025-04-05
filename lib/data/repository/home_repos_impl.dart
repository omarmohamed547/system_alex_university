import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/domain/entites/GetCourses_response_Entity.dart';
import 'package:system_alex_univ/domain/entites/Get_Course_byDoctor_Entity.dart';
import 'package:system_alex_univ/domain/repository/home_doc/home_remoteDataSource.dart';
import 'package:system_alex_univ/domain/repository/home_doc/home_repos.dart';

@Injectable(as: HomeRepos)
class HomeReposImpl implements HomeRepos {
  HomeRemotedatasource homeRemotedatasource;
  HomeReposImpl({required this.homeRemotedatasource});
  @override
  Future<Either<Failure, List<GetCoursesResponseEntity>>> getCourses() async {
    var either = await homeRemotedatasource.getCourses();
    return either.fold((error) {
      return Left(error);
    }, (response) {
      return Right(response);
    });
  }
/*
  @override
  Future<Either<Failure, GetCoursesByDoctorEntity>> getCoursesByDoctor() async {
    var either = await homeRemotedatasource.getCoursesByDoctor();
    return either.fold((error) {
      return Left(error);
    }, (response) {
      return Right(response);
    });
  }*/
}
