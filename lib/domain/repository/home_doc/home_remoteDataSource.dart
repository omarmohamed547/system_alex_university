import 'package:either_dart/either.dart';
import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/domain/entites/GetCourses_response_Entity.dart';
import 'package:system_alex_univ/domain/entites/Get_Course_byDoctor_Entity.dart';

abstract class HomeRemotedatasource {
  Future<Either<Failure, List<GetCoursesResponseEntity>>> getCourses();
  // Future<Either<Failure, GetCoursesByDoctorEntity>> getCoursesByDoctor();
}
