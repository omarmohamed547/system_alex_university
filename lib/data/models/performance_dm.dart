import 'package:system_alex_univ/domain/entites/performace_entity.dart';

class PerformaceReponseDm extends PerformaceResponseEntity {
  PerformaceReponseDm({
    super.message,
    super.student,
    super.performance,
  });

  factory PerformaceReponseDm.fromJson(Map<String, dynamic> json) {
    return PerformaceReponseDm(
      message: json["message"],
      student:
          json["student"] == null ? null : StudentDm.fromJson(json["student"]),
      performance: json["performance"] == null
          ? null
          : PerformanceDm.fromJson(json["performance"]),
    );
  }
}

class PerformanceDm extends PerformanceEntity {
  PerformanceDm({
    super.cgpa,
    super.termGpa,
    super.passedCourses,
    super.totalCreditHoursCompleted,
    super.remainingCreditHours,
    super.academicLevel,
    super.maxAllowedCreditHours,
  });

  factory PerformanceDm.fromJson(Map<String, dynamic> json) {
    return PerformanceDm(
      cgpa: json["cgpa"],
      termGpa: json["termGpa"],
      passedCourses: json["passedCourses"] == null
          ? []
          : List<PassedCourseDm>.from(
              json["passedCourses"]!.map((x) => PassedCourseDm.fromJson(x))),
      totalCreditHoursCompleted: json["totalCreditHoursCompleted"],
      remainingCreditHours: json["remainingCreditHours"],
      academicLevel: json["academicLevel"],
      maxAllowedCreditHours: json["maxAllowedCreditHours"],
    );
  }
}

class PassedCourseDm extends PassedCourseEntity {
  PassedCourseDm({
    super.code,
    super.name,
    super.creditHours,
    super.score,
    super.grade,
    super.term,
  });

  factory PassedCourseDm.fromJson(Map<String, dynamic> json) {
    return PassedCourseDm(
      code: json["code"],
      name: json["name"],
      creditHours: json["creditHours"],
      score: json["score"],
      grade: json["grade"],
      term: json["term"],
    );
  }
}

class StudentDm extends StudentEntity {
  StudentDm({
    super.id,
    super.name,
    super.email,
  });

  factory StudentDm.fromJson(Map<String, dynamic> json) {
    return StudentDm(
      id: json["id"],
      name: json["name"],
      email: json["email"],
    );
  }
}
