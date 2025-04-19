import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/domain/entites/ExamTable_entity.dart';
import 'package:system_alex_univ/domain/repository/examTable/ExamTable_repos.dart';

@injectable
class GetExamTableUsecase {
  ExamtableRepos examtableRepos;
  GetExamTableUsecase({required this.examtableRepos});
  Future<Either<Failure, ExamTableEntity>> invoke() {
    return examtableRepos.getExamTable();
  }
}
