import 'package:either_dart/either.dart';
import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/domain/entites/ExamTable_entity.dart';

abstract class ExamtableRepos {
  Future<Either<Failure, ExamTableEntity>> getExamTable();
}
