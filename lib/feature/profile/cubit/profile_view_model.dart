import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:system_alex_univ/domain/UseCases/drop_cource_useCase.dart';
import 'package:system_alex_univ/domain/UseCases/getAvliableCourseStudent.dart';
import 'package:system_alex_univ/domain/UseCases/get_profilePicture.dart';
import 'package:system_alex_univ/domain/UseCases/registerSectionUseCase.dart';
import 'package:system_alex_univ/domain/UseCases/register_course_useCase.dart';
import 'package:system_alex_univ/domain/entites/AvliableCourseStudent_entity.dart';
import 'package:system_alex_univ/feature/profile/cubit/profile_states.dart';
import 'package:system_alex_univ/feature/registiration/cubit/registiration_states.dart';

@injectable
class ProfileViewModel extends Cubit<ProfileStates> {
  GetProfilepictureUseCase getProfilepictureUseCase;

  ProfileViewModel({
    required this.getProfilepictureUseCase,
  }) : super(LoadingProfilePicture());

  static ProfileViewModel get(context) =>
      BlocProvider.of<ProfileViewModel>(context);

  void getProfilePicture() async {
    emit(LoadingProfilePicture());
    var either = await getProfilepictureUseCase.invoke();
    either.fold((error) {
      emit(FailureProfilePicture(error: error));
    }, (response) {
      emit(SuccessProfilePicture(profilePictureEntity: response));
    });
  }
}
