import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:system_alex_univ/domain/UseCases/get_courses_useCase.dart';
import 'package:system_alex_univ/domain/UseCases/get_examTable.dart';
import 'package:system_alex_univ/domain/UseCases/get_time_table_useCase.dart';
import 'package:system_alex_univ/feature/ExamTable/cubit/examtable_states.dart';
import 'package:system_alex_univ/feature/home/cubit/home_state.dart';

@injectable
class Examtableviesmodel extends Cubit<ExamtableStates> {
  Examtableviesmodel({required this.getExamTableUsecase})
      : super(LoadingGetExamTable());
  GetExamTableUsecase getExamTableUsecase;
  static Examtableviesmodel get(context) =>
      BlocProvider.of<Examtableviesmodel>(context);

  void getExamTable() async {
    emit(LoadingGetExamTable());
    var either = await getExamTableUsecase.invoke();
    either.fold((error) {
      emit(FailureGetExamTable(error: error));
    }, (response) {
      emit(SucessGetExamTable(examTableEntity: response));
    });
  }
}
