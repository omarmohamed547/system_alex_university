import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/domain/entites/ExamTable_entity.dart';

abstract class ExamtableStates {}

class LoadingGetExamTable extends ExamtableStates {}

class FailureGetExamTable extends ExamtableStates {
  Failure error;
  FailureGetExamTable({required this.error});
}

class SucessGetExamTable extends ExamtableStates {
  ExamTableEntity examTableEntity;
  SucessGetExamTable({required this.examTableEntity});
}
