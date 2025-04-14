import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/domain/entites/performace_entity.dart';
import 'package:system_alex_univ/domain/repository/performance/performance_repos.dart';

@injectable
class GetPerformanceUsecase {
  PerformanceRepos performanceRepos;
  GetPerformanceUsecase({required this.performanceRepos});
  Future<Either<Failure, PerformaceResponseEntity>> invoke() {
    return performanceRepos.getPerformace();
  }
}
