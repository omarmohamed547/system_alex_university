import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/domain/entites/AvliableCourseStudent_entity.dart';
import 'package:system_alex_univ/domain/repository/register_student/registerStu_repos.dart';

@injectable
class RegisterCourseUsecase {
  RegisterstudentRepos registerstudentRepos;
  RegisterCourseUsecase({required this.registerstudentRepos});

  Future<Either<Failure, RegisterCourseEntity>> invoke(String coursecodes) {
    return registerstudentRepos.registerCourse(coursecodes);
  }
}
