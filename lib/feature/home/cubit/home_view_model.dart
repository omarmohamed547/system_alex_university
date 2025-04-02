import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:system_alex_univ/domain/UseCases/get_courses_useCase.dart';
import 'package:system_alex_univ/feature/home/cubit/home_state.dart';

@injectable
class HomeViewModel extends Cubit<HomeState> {
  HomeViewModel({required this.getCoursesUsecase}) : super(LoadingGetCourse());
  GetCoursesUsecase getCoursesUsecase;
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
}
