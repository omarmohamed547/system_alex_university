import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/data/dataSource/register_stu_dataSource.dart';
import 'package:system_alex_univ/domain/entites/AvliableCourseStudent_entity.dart';
import 'package:system_alex_univ/domain/repository/register_student/registerStu_dataSource.dart';
import 'package:system_alex_univ/domain/repository/register_student/registerStu_repos.dart';

@Injectable(as: RegisterstudentRepos)
class RegisterStuReposimpl extends RegisterstudentRepos {
  RegistertuDatasource registerStuDatasource;
  RegisterStuReposimpl({required this.registerStuDatasource});
  @override
  Future<Either<Failure, AvaliableCoursesForStudentEntity>>
      getAvaliableCourse() async {
    var either = await registerStuDatasource.getAvaliableCourse();
    return either.fold((error) {
      return Left(error);
    }, (response) {
      return Right(response);
    });
  }

  @override
  Future<Either<Failure, RegisterCourseEntity>> registerCourse(
      String coursecodes) async {
    var either = await registerStuDatasource.registerCourse(coursecodes);
    return either.fold((error) {
      return Left(error);
    }, (response) {
      return Right(response);
    });
  }

  @override
  Future<Either<Failure, RegisterCourseEntity>> dropCourse(
      String coursecodes) async {
    var either = await registerStuDatasource.dropCourse(coursecodes);
    return either.fold((error) {
      return Left(error);
    }, (response) {
      return Right(response);
    });
  }

  @override
  Future<Either<Failure, RegisterCourseEntity>> registerSection(
      String coursecodes, String sectionId) async {
    var either =
        await registerStuDatasource.registerSection(coursecodes, sectionId);
    return either.fold((error) {
      return Left(error);
    }, (response) {
      return Right(response);
    });
  }
}
