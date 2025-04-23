import 'package:system_alex_univ/domain/entites/AvliableCourseStudent_entity.dart';

class AvaliableCourseStudentDm extends AvaliableCoursesForStudentEntity {
  AvaliableCourseStudentDm({
    super.message,
    super.courses,
    super.failedCourses,
    super.registeredCourses,
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
      registeredCourses: json["registeredCourses"] == null
          ? []
          : List<String>.from(json["registeredCourses"]!.map((x) => x)),
    );
  }
}

class CoursestudentDm extends CourseStudentEntity {
  CoursestudentDm(
      {super.code,
      super.name,
      super.lectureSessions,
      super.doctorName,
      super.sections,
      super.isFailedCourse,
      super.creditHours,
      super.prerequisites,
      required super.isRegistered});

  factory CoursestudentDm.fromJson(Map<String, dynamic> json) {
    return CoursestudentDm(
      code: json["code"],
      name: json["name"],
      isRegistered: json["isRegistered"],
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
  RegisterCourseDm(
      {super.message,
      super.term,
      super.totalCreditHours,
      super.registeredCourses});

  factory RegisterCourseDm.fromJson(Map<String, dynamic> json) {
    return RegisterCourseDm(
      message: json["message"],
      registeredCourses: json["registeredCourses"] == null
          ? []
          : List<String>.from(json["registeredCourses"]!.map((x) => x)),
      term: json["term"],
      totalCreditHours: json["totalCreditHours"],
    );
  }
}

class RegisterSectionDm extends RegisterSectionEntity {
  RegisterSectionDm({
    super.message,
    super.registeredSections,
    super.timeConflicts,
  });

  factory RegisterSectionDm.fromJson(Map<String, dynamic> json) {
    return RegisterSectionDm(
      timeConflicts: json["timeConflicts"] == null
          ? []
          : List<TimeConflictDm>.from(
              json["timeConflicts"]!.map((x) => TimeConflictDm.fromJson(x))),
      message: json["message"],
      registeredSections: json["registeredSections"] == null
          ? []
          : List<RegisteredSection>.from(json["registeredSections"]!
              .map((x) => RegisteredSection.fromJson(x))),
    );
  }
}

class TimeConflictDm extends TimeConflictEntity {
  TimeConflictDm({
    super.courseCode,
    super.sectionId,
    super.message,
  });

  factory TimeConflictDm.fromJson(Map<String, dynamic> json) {
    return TimeConflictDm(
      courseCode: json["courseCode"],
      sectionId: json["sectionId"],
      message: json["message"],
    );
  }

  Map<String, dynamic> toJson() => {
        "courseCode": courseCode,
        "sectionId": sectionId,
        "message": message,
      };
}

class RegisteredSection extends RegisteredSectionEntity {
  RegisteredSection({
    super.courseCode,
    super.sectionId,
  });

  factory RegisteredSection.fromJson(Map<String, dynamic> json) {
    return RegisteredSection(
      courseCode: json["courseCode"],
      sectionId: json["sectionId"],
    );
  }
}

class DropCourseDm extends DropCourseEntity {
  DropCourseDm({
    super.message,
    super.droppedSections,
  });

  factory DropCourseDm.fromJson(Map<String, dynamic> json) {
    return DropCourseDm(
      message: json["message"],
      droppedSections: json["droppedSections"] == null
          ? []
          : List<String>.from(json["droppedSections"]!.map((x) => x)),
    );
  }
}

class DropSecDm extends DropSecEntity {
  DropSecDm({
    super.message,
  });

  factory DropSecDm.fromJson(Map<String, dynamic> json) {
    return DropSecDm(
      message: json["message"],
    );
  }
}
