import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/domain/entites/Course_TimeTable_entity.dart';
import 'package:system_alex_univ/domain/repository/home_stu/time_table_dataSource.dart';
import 'package:system_alex_univ/domain/repository/home_stu/time_table_repos.dart';

@Injectable(as: TimeTableRepos)
class TimeTableReposImpl implements TimeTableRepos {
  TimeTableDatasource tableDatasource;
  TimeTableReposImpl({required this.tableDatasource});
  @override
  Future<Either<Failure, CourseTableEntity>> getTimeTable() async {
    var either = await tableDatasource.getTimeTable();
    return either.fold((error) {
      return Left(error);
    }, (response) {
      return Right(response);
    });
  }
}
