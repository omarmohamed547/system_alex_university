import 'package:system_alex_univ/domain/entites/GetCourses_response_Entity.dart';

class GetCoursesByDoctorEntity {
  GetCoursesByDoctorEntity({
    required this.doctor,
    required this.courses,
  });

  final DoctorEntity? doctor;
  final List<GetCoursesResponseEntity>? courses;
}

class DoctorEntity {
  DoctorEntity({
    required this.id,
    required this.name,
    required this.email,
  });

  final String? id;
  final String? name;
  final String? email;
}
