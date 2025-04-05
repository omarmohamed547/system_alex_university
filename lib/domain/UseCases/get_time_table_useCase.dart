import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/domain/entites/Course_TimeTable_entity.dart';
import 'package:system_alex_univ/domain/repository/home_stu/time_table_repos.dart';

@injectable
class GetTimeTableUsecase {
  TimeTableRepos homeStudentRepos;
  GetTimeTableUsecase({required this.homeStudentRepos});
  Future<Either<Failure, CourseTableEntity>> invoke() {
    return homeStudentRepos.getTimeTable();
  }
}
