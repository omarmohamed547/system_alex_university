import 'package:either_dart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/domain/entites/performace_entity.dart';
import 'package:system_alex_univ/domain/repository/performance/performance_dataSource.dart';
import 'package:system_alex_univ/domain/repository/performance/performance_repos.dart';

@Injectable(as: PerformanceRepos)
class PerformanceReposImpl implements PerformanceRepos {
  PerformanceDatasource performanceDatasource;
  PerformanceReposImpl({required this.performanceDatasource});
  @override
  Future<Either<Failure, PerformaceResponseEntity>> getPerformace() async {
    var either = await performanceDatasource.getPerformace();
    return either.fold((error) {
      return Left(error);
    }, (response) {
      return Right(response);
    });
  }
}
