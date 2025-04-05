import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/domain/entites/AvliableCourseStudent_entity.dart';
import 'package:system_alex_univ/domain/entites/GetCourses_response_Entity.dart';
import 'package:system_alex_univ/domain/entites/Get_Course_byDoctor_Entity.dart';

abstract class RegistirationState {}

class LoadingGetCourseByDoctor extends RegistirationState {}

class FailureGetCourseByDoctor extends RegistirationState {
  Failure error;
  FailureGetCourseByDoctor({required this.error});
}

class SucessGetCourseByDoctor extends RegistirationState {
  final AvaliableCoursesForStudentEntity avaliableCoursesForStudentEntity;
  SucessGetCourseByDoctor({required this.avaliableCoursesForStudentEntity});
}

class FailureRegisterCourse extends RegistirationState {
  Failure error;
  FailureRegisterCourse({required this.error});
}

class SucessRegisterCourse extends RegistirationState {
  final RegisterCourseEntity registerCourseEntity;
  SucessRegisterCourse({required this.registerCourseEntity});
}

class FailureDropCourse extends RegistirationState {
  Failure error;
  FailureDropCourse({required this.error});
}

class SucessDropCourse extends RegistirationState {
  final RegisterCourseEntity registerCourseEntity;
  SucessDropCourse({required this.registerCourseEntity});
}

class LastUpdateCourse extends RegistirationState {}
