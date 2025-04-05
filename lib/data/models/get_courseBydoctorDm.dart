import 'package:system_alex_univ/data/models/get_courses_responseDm.dart';
import 'package:system_alex_univ/domain/entites/Get_Course_byDoctor_Entity.dart';

class GetCoursesByDoctorDm extends GetCoursesByDoctorEntity {
  GetCoursesByDoctorDm({
    super.doctor,
    super.courses,
  });

  factory GetCoursesByDoctorDm.fromJson(Map<String, dynamic> json) {
    return GetCoursesByDoctorDm(
      doctor: json["doctor"] == null ? null : Doctor.fromJson(json["doctor"]),
      courses: json["courses"] == null
          ? []
          : List<GetCoursesResponseDm>.from(
              json["courses"]!.map((x) => GetCoursesResponseDm.fromJson(x))),
    );
  }
}

class Doctor extends DoctorEntity {
  Doctor({
    super.id,
    super.name,
    super.email,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json["id"],
      name: json["name"],
      email: json["email"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
      };
}
