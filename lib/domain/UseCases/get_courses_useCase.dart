import 'package:either_dart/either.dart';
import 'package:injectable/injectable.dart';
import 'package:system_alex_univ/core/utils/errors/failure.dart';
import 'package:system_alex_univ/domain/entites/GetCourses_response_Entity.dart';
import 'package:system_alex_univ/domain/repository/home_doc/home_repos.dart';

@injectable
class GetCoursesUsecase {
  HomeRepos homeRepos;
  GetCoursesUsecase({required this.homeRepos});

  Future<Either<Failure, List<GetCoursesResponseEntity>>> invoke() {
    return homeRepos.getCourses();
  }
}
