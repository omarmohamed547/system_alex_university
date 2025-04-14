import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:system_alex_univ/domain/UseCases/get_performance_useCase.dart';
import 'package:system_alex_univ/domain/entites/performace_entity.dart';
import 'package:system_alex_univ/feature/performance/cubit/performance_states.dart';

@injectable
class PerformanceViewModel extends Cubit<PerformanceStates> {
  PerformanceViewModel({required this.getPerformanceUsecase})
      : super(LoadingPerformanceState());
  GetPerformanceUsecase getPerformanceUsecase;
  List<PassedCourseEntity> filteredCoursesList = [];

  static PerformanceViewModel get(context) =>
      BlocProvider.of<PerformanceViewModel>(context);

  void getPerformance() async {
    emit(LoadingPerformanceState());
    var either = await getPerformanceUsecase.invoke();
    either.fold((error) {
      emit(FailurePerformanceState(error: error));
    }, (response) {
      filteredCoursesList = response.performance?.passedCourses ?? [];

      emit(SuccessPerformanceState(performaceResponseEntity: response));
    });
  }

  // Method to handle course search
  void filterCourses(List<PassedCourseEntity> allCourses, String query) {
    if (query.isEmpty) {
      filteredCoursesList = allCourses;
    } else {
      filteredCoursesList = allCourses
          .where((course) =>
              course.name?.toLowerCase().contains(query.toLowerCase()) ?? false)
          .toList();
    }

    // Optionally emit a new state to force rebuild
    emit(SearchUpdatedState(filteredCoursesList));
  }
}
