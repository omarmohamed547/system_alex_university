import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:system_alex_univ/domain/UseCases/drop_cource_useCase.dart';
import 'package:system_alex_univ/domain/UseCases/getAvliableCourseStudent.dart';
import 'package:system_alex_univ/domain/UseCases/register_course_useCase.dart';
import 'package:system_alex_univ/domain/entites/AvliableCourseStudent_entity.dart';
import 'package:system_alex_univ/feature/registiration/cubit/registiration_states.dart';

@injectable
class RegistirationnViewModel extends Cubit<RegistirationState> {
  GetavliablecoursestudentUseCase getavliablecoursestudentUseCase;
  RegisterCourseUsecase registerCourseUsecase;
  DropCourceUsecase dropCourceUsecase;
  RegistirationnViewModel(
      {required this.getavliablecoursestudentUseCase,
      required this.dropCourceUsecase,
      required this.registerCourseUsecase})
      : super(LoadingGetCourseByDoctor());

  static RegistirationnViewModel get(context) =>
      BlocProvider.of<RegistirationnViewModel>(context);

  void getAvliableCourse() async {
    emit(LoadingGetCourseByDoctor());
    var either = await getavliablecoursestudentUseCase.invoke();
    either.fold((error) {
      emit(FailureGetCourseByDoctor(error: error));
    }, (response) {
      emit(LastUpdateCourse());

      emit(SucessGetCourseByDoctor(avaliableCoursesForStudentEntity: response));
    });
  }

  void registerCourse(String coursecodes) async {
    var either = await registerCourseUsecase.invoke(coursecodes);
    either.fold((error) {
      emit(FailureRegisterCourse(error: error));
    }, (response) {
      emit(SucessRegisterCourse(registerCourseEntity: response));
      emit(LastUpdateCourse());
    });
  }

  void dropCourse(String coursecodes) async {
    var either = await dropCourceUsecase.invoke(coursecodes);
    either.fold((error) {
      emit(FailureDropCourse(error: error));
    }, (response) {
      emit(SucessDropCourse(registerCourseEntity: response));
      emit(LastUpdateCourse());
    });
  }
}
