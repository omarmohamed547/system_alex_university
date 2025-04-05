import 'package:either_dart/either.dart';
import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/domain/entites/AvliableCourseStudent_entity.dart';

abstract class RegistertuDatasource {
  Future<Either<Failure, AvaliableCoursesForStudentEntity>>
      getAvaliableCourse();

  Future<Either<Failure, RegisterCourseEntity>> registerCourse(
      String coursecodes);
  Future<Either<Failure, RegisterCourseEntity>> dropCourse(String coursecodes);
}
