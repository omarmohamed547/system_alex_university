import 'package:system_alex_univ/domain/entites/GetCourses_response_Entity.dart';

class GetCoursesResponseDm extends GetCoursesResponseEntity {
  GetCoursesResponseDm(
      {super.id,
      super.name,
      super.code,
      super.doctorId,
      super.creditHours,
      super.prerequisites,
      super.registeredStudents,
      super.sections,
      super.lectureSessions,
      super.semester,
      super.startDate,
      super.endDate,
      super.department,
      super.capacity,
      super.isActive,
      super.v,
      this.message});

  final String? message;

  /// Factory method to handle **both single object & list responses**
  static List<GetCoursesResponseDm> fromJsonList(dynamic json) {
    if (json is List) {
      // Convert each item in the list to a GetCoursesResponseDm instance
      return json.map((e) => GetCoursesResponseDm.fromJson(e)).toList();
    } else if (json is Map<String, dynamic>) {
      // If the response is a single object, wrap it in a list
      return [GetCoursesResponseDm.fromJson(json)];
    } else {
      throw Exception("Unexpected JSON format: $json");
    }
  }

  factory GetCoursesResponseDm.fromJson(Map<String, dynamic> json) {
    return GetCoursesResponseDm(
      id: json["_id"],
      name: json["name"],
      code: json["code"],
      doctorId: json["doctorId"],
      creditHours: json["creditHours"],
      prerequisites: json["prerequisites"] == null
          ? []
          : List<String>.from(json["prerequisites"].map((x) => x)),
      registeredStudents: json["registeredStudents"] == null
          ? []
          : List<String>.from(json["registeredStudents"].map((x) => x)),
      sections: json["sections"] == null
          ? []
          : List<SectionDm>.from(
              json["sections"].map((x) => SectionDm.fromJson(x))),
      lectureSessions: json["lectureSessions"] == null
          ? []
          : List<SessionDm>.from(
              json["lectureSessions"].map((x) => SessionDm.fromJson(x))),
      semester: json["semester"],
      startDate: DateTime.tryParse(json["startDate"] ?? ""),
      endDate: DateTime.tryParse(json["endDate"] ?? ""),
      department: json["department"],
      capacity: json["capacity"],
      isActive: json["isActive"],
      v: json["__v"],
    );
  }
}

class SessionDm extends SessionEntity {
  SessionDm({
    super.day,
    super.startTime,
    super.endTime,
    super.room,
    super.type,
    super.id,
  });

  factory SessionDm.fromJson(Map<String, dynamic> json) {
    return SessionDm(
      day: json["day"] ?? "Unknown Day",
      startTime: json["startTime"] ?? "00:00",
      endTime: json["endTime"] ?? "00:00",
      room: json["room"] ?? "Unknown Room",
      type: json["type"] ?? "Unknown Type",
      id: json["_id"] ?? "",
    );
  }
}

class SectionDm extends SectionEntity {
  SectionDm({
    super.sectionId,
    super.taId,
    super.capacity,
    super.registeredStudents,
    super.sessions,
    super.isFull,
    super.id,
  });

  factory SectionDm.fromJson(Map<String, dynamic> json) {
    return SectionDm(
      sectionId: json["sectionId"] ?? "",
      taId: json["taId"] ?? "",
      capacity: json["capacity"] ?? 0,
      registeredStudents: (json["registeredStudents"] as List?)
              ?.map((x) => x as String)
              .toList() ??
          [],
      sessions: (json["sessions"] as List?)
              ?.map((x) => SessionDm.fromJson(x))
              .toList() ??
          [],
      isFull: json["isFull"] ?? false,
      id: json["_id"] ?? "",
    );
  }
}
