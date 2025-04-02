import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/domain/entites/GetCourses_response_Entity.dart';

abstract class HomeState {}

class LoadingGetCourse extends HomeState {}

class FailureGetCourse extends HomeState {
  Failure error;
  FailureGetCourse({required this.error});
}

class SucessGetCourse extends HomeState {
  final List<GetCoursesResponseEntity> getCoursesResponseEntities;
  SucessGetCourse({required this.getCoursesResponseEntities});
}
