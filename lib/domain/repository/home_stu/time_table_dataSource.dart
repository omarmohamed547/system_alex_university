import 'package:either_dart/either.dart';
import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/domain/entites/Course_TimeTable_entity.dart';

abstract class TimeTableDatasource {
  Future<Either<Failure, CourseTableEntity>> getTimeTable();
}
