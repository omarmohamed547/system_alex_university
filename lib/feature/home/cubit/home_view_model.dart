import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:system_alex_univ/domain/UseCases/get_courses_useCase.dart';
import 'package:system_alex_univ/domain/UseCases/get_time_table_useCase.dart';
import 'package:system_alex_univ/feature/home/cubit/home_state.dart';

@injectable
class HomeViewModel extends Cubit<HomeState> {
  HomeViewModel(
      {required this.getCoursesUsecase, required this.getTimeTableUsecase})
      : super(LoadingGetCourse());
  GetCoursesUsecase getCoursesUsecase;
  GetTimeTableUsecase getTimeTableUsecase;
  static HomeViewModel get(context) => BlocProvider.of<HomeViewModel>(context);

  void getCourses() async {
    emit(LoadingGetCourse());
    var either = await getCoursesUsecase.invoke();
    either.fold((error) {
      emit(FailureGetCourse(error: error));
    }, (response) {
      emit(SucessGetCourse(getCoursesResponseEntities: response));
    });
  }

  void getTimeTable() async {
    emit(LoadingGettimeTable());
    var either = await getTimeTableUsecase.invoke();
    either.fold((error) {
      emit(FailureGettimeTable(error: error));
    }, (response) {
      emit(SucessGettimeTable(courseTableEntity: response));
    });
  }
}
