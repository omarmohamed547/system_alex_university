class PerformaceResponseEntity {
  PerformaceResponseEntity({
    required this.message,
    required this.student,
    required this.performance,
  });

  final String? message;
  final StudentEntity? student;
  final PerformanceEntity? performance;
}

class PerformanceEntity {
  PerformanceEntity({
    required this.cgpa,
    required this.termGpa,
    required this.passedCourses,
    required this.totalCreditHoursCompleted,
    required this.remainingCreditHours,
    required this.academicLevel,
    required this.maxAllowedCreditHours,
  });

  final num? cgpa;
  final num? termGpa;
  final List<PassedCourseEntity>? passedCourses;
  final num? totalCreditHoursCompleted;
  final num? remainingCreditHours;
  final String? academicLevel;
  final num? maxAllowedCreditHours;
}

class PassedCourseEntity {
  PassedCourseEntity({
    required this.code,
    required this.name,
    required this.creditHours,
    required this.score,
    required this.grade,
    required this.term,
  });

  final String? code;
  final String? name;
  final num? creditHours;
  final num? score;
  final String? grade;
  final String? term;
}

class StudentEntity {
  StudentEntity({
    required this.id,
    required this.name,
    required this.email,
  });

  final String? id;
  final String? name;
  final String? email;
}
