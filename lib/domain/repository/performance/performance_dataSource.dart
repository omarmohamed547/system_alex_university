import 'package:either_dart/either.dart';
import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/domain/entites/performace_entity.dart';

abstract class PerformanceDatasource {
  Future<Either<Failure, PerformaceResponseEntity>> getPerformace();
}
