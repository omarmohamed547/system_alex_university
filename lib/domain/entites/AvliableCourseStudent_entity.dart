class AvaliableCoursesForStudentEntity {
  AvaliableCoursesForStudentEntity({
    required this.message,
    required this.courses,
    required this.failedCourses,
  });

  final String? message;
  final List<CourseStudentEntity>? courses;
  final List<dynamic>? failedCourses;
}

class CourseStudentEntity {
  CourseStudentEntity({
    required this.code,
    required this.name,
    required this.lectureSessions,
    required this.doctorName,
    required this.sections,
    required this.isFailedCourse,
    required this.creditHours,
    required this.prerequisites,
  });

  final String? code;
  final String? name;
  final List<SessionStudentEntity>? lectureSessions;
  final String? doctorName;
  final List<SectionStudentEntity>? sections;
  final bool? isFailedCourse;
  final num? creditHours;
  final List<String>? prerequisites;
}

class SessionStudentEntity {
  SessionStudentEntity({
    required this.day,
    required this.startTime,
    required this.endTime,
    required this.room,
    required this.type,
    required this.id,
  });

  final String? day;
  final String? startTime;
  final String? endTime;
  final String? room;
  final String? type;
  final String? id;
}

class SectionStudentEntity {
  SectionStudentEntity({
    required this.sectionId,
    required this.sessions,
    required this.teachingAssistant,
    required this.capacity,
    required this.registeredStudents,
  });

  final String? sectionId;
  final List<SessionStudentEntity>? sessions;
  final String? teachingAssistant;
  final num? capacity;
  final num? registeredStudents;
}

class RegisterCourseEntity {
  RegisterCourseEntity({
    required this.message,
    required this.alreadyRegistered,
  });

  final String? message;
  final List<String>? alreadyRegistered;
}

class RegisterSectionEntity {
  RegisterSectionEntity({
    required this.message,
    required this.registeredSections,
  });

  final String? message;
  final List<RegisteredSectionEntity>? registeredSections;
}

class RegisteredSectionEntity {
  RegisteredSectionEntity({
    required this.courseCode,
    required this.sectionId,
  });

  final String? courseCode;
  final String? sectionId;
}
