import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/domain/entites/performace_entity.dart';

class PerformanceStates {}

class LoadingPerformanceState extends PerformanceStates {}

class FailurePerformanceState extends PerformanceStates {
  Failure error;
  FailurePerformanceState({required this.error});
}

class SuccessPerformanceState extends PerformanceStates {
  PerformaceResponseEntity performaceResponseEntity;
  SuccessPerformanceState({required this.performaceResponseEntity});
}

class SearchUpdatedState extends PerformanceStates {
  final List<PassedCourseEntity> updatedList;
  SearchUpdatedState(this.updatedList);
}
