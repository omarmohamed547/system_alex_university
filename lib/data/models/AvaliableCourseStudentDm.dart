import 'package:system_alex_univ/domain/entites/AvliableCourseStudent_entity.dart';

class AvaliableCourseStudentDm extends AvaliableCoursesForStudentEntity {
  AvaliableCourseStudentDm({
    super.message,
    super.courses,
    super.failedCourses,
  });

  factory AvaliableCourseStudentDm.fromJson(Map<String, dynamic> json) {
    return AvaliableCourseStudentDm(
      message: json["message"],
      courses: json["courses"] == null
          ? []
          : List<CoursestudentDm>.from(
              json["courses"]!.map((x) => CoursestudentDm.fromJson(x))),
      failedCourses: json["failedCourses"] == null
          ? []
          : List<dynamic>.from(json["failedCourses"]!.map((x) => x)),
    );
  }
}

class CoursestudentDm extends CourseStudentEntity {
  CoursestudentDm({
    super.code,
    super.name,
    super.lectureSessions,
    super.doctorName,
    super.sections,
    super.isFailedCourse,
    super.creditHours,
    super.prerequisites,
  });

  factory CoursestudentDm.fromJson(Map<String, dynamic> json) {
    return CoursestudentDm(
      code: json["code"],
      name: json["name"],
      lectureSessions: json["lectureSessions"] == null
          ? []
          : List<SessionStudentDm>.from(json["lectureSessions"]!
              .map((x) => SessionStudentDm.fromJson(x))),
      doctorName: json["doctorName"],
      sections: json["sections"] == null
          ? []
          : List<SectionStudentDm>.from(
              json["sections"]!.map((x) => SectionStudentDm.fromJson(x))),
      isFailedCourse: json["isFailedCourse"],
      creditHours: json["creditHours"],
      prerequisites: json["prerequisites"] == null
          ? []
          : List<String>.from(json["prerequisites"]!.map((x) => x)),
    );
  }
}

class SessionStudentDm extends SessionStudentEntity {
  SessionStudentDm({
    super.day,
    super.startTime,
    super.endTime,
    super.room,
    super.type,
    super.id,
  });

  factory SessionStudentDm.fromJson(Map<String, dynamic> json) {
    return SessionStudentDm(
      day: json["day"],
      startTime: json["startTime"],
      endTime: json["endTime"],
      room: json["room"],
      type: json["type"],
      id: json["_id"],
    );
  }
}

class SectionStudentDm extends SectionStudentEntity {
  SectionStudentDm({
    super.sectionId,
    super.sessions,
    super.teachingAssistant,
    super.capacity,
    super.registeredStudents,
  });

  factory SectionStudentDm.fromJson(Map<String, dynamic> json) {
    return SectionStudentDm(
      sectionId: json["sectionId"],
      sessions: json["sessions"] == null
          ? []
          : List<SessionStudentDm>.from(
              json["sessions"]!.map((x) => SessionStudentDm.fromJson(x))),
      teachingAssistant: json["teachingAssistant"],
      capacity: json["capacity"],
      registeredStudents: json["registeredStudents"],
    );
  }
}

class RegisterCourseDm extends RegisterCourseEntity {
  RegisterCourseDm({
    super.message,
    super.alreadyRegistered,
  });

  factory RegisterCourseDm.fromJson(Map<String, dynamic> json) {
    return RegisterCourseDm(
      message: json["message"],
      alreadyRegistered: json["alreadyRegistered"] == null
          ? []
          : List<String>.from(json["alreadyRegistered"]!.map((x) => x)),
    );
  }
}
