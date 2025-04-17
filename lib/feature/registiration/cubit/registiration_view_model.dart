import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:system_alex_univ/domain/UseCases/drop_cource_useCase.dart';
import 'package:system_alex_univ/domain/UseCases/getAvliableCourseStudent.dart';
import 'package:system_alex_univ/domain/UseCases/registerSectionUseCase.dart';
import 'package:system_alex_univ/domain/UseCases/register_course_useCase.dart';
import 'package:system_alex_univ/domain/entites/AvliableCourseStudent_entity.dart';
import 'package:system_alex_univ/feature/registiration/cubit/registiration_states.dart';

@injectable
class RegistirationnViewModel extends Cubit<RegistirationState> {
  GetavliablecoursestudentUseCase getavliablecoursestudentUseCase;
  RegisterCourseUsecase registerCourseUsecase;
  RegisterSectionUsecase registerSectionUsecase;
  DropCourceUsecase dropCourceUsecase;
  bool isCourseRegistered = false; // Track course registration status

  RegistirationnViewModel(
      {required this.getavliablecoursestudentUseCase,
      required this.registerSectionUsecase,
      required this.dropCourceUsecase,
      required this.registerCourseUsecase})
      : super(LoadingGetAvaliableCourse());

  static RegistirationnViewModel get(context) =>
      BlocProvider.of<RegistirationnViewModel>(context);

  void getAvliableCourse() async {
    emit(LoadingGetAvaliableCourse());
    var either = await getavliablecoursestudentUseCase.invoke();
    either.fold((error) {
      emit(FailureGetAvaliableCourse(error: error));
    }, (response) {
      emit(LastUpdateCourse());

      emit(
          SucessGetAvaliableCourse(avaliableCoursesForStudentEntity: response));
    });
  }

  Future<String?> registerCourse(String coursecodes) async {
    var either = await registerCourseUsecase.invoke(coursecodes);
    return either.fold((error) {
      emit(FailureRegisterCourse(error: error));
      return error.errorMessage;
    }, (response) {
      isCourseRegistered = true;
      emit(SucessRegisterCourse(registerCourseEntity: response));
      emit(LastUpdateCourse());
      return null; // success
    });
  }

  Future<String?> registerSection(String coursecodes, String sectionId) async {
    var either = await registerSectionUsecase.invoke(coursecodes, sectionId);
    return either.fold((error) {
      emit(FailureRegisterSec(error: error));
      return error.errorMessage;
    }, (response) {
      emit(SucessRegisterSec(registerSectionEntity: response));
      emit(LastUpdateCourse());
      return null; // success
    });
  }

  Future<String?> dropCourse(String coursecodes) async {
    var either = await dropCourceUsecase.invoke(coursecodes);
    return either.fold((error) {
      emit(FailureDropCourse(error: error));
      return error.errorMessage;
    }, (response) {
      emit(SucessDropCourse(dropCourseEntity: response));
      emit(LastUpdateCourse());
      return null; // success
    });
  }
}
