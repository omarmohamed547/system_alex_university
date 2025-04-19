import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/domain/entites/ExamTable_entity.dart';
import 'package:system_alex_univ/domain/repository/examTable/ExamTable_dataSource.dart';
import 'package:system_alex_univ/domain/repository/examTable/ExamTable_repos.dart';

@Injectable(as: ExamtableRepos)
class TimeTableReposImpl implements ExamtableRepos {
  ExamtableDatasource examtableDatasource;
  TimeTableReposImpl({required this.examtableDatasource});

  @override
  Future<Either<Failure, ExamTableEntity>> getExamTable() async {
    var either = await examtableDatasource.getExamTable();
    return either.fold((error) {
      return Left(error);
    }, (response) {
      return Right(response);
    });
  }
}
