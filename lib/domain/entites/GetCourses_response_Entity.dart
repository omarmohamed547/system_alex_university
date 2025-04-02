import 'package:system_alex_univ/data/models/get_courses_responseDm.dart';

class GetCoursesResponseEntity {
  GetCoursesResponseEntity({
    required this.id,
    required this.name,
    required this.code,
    required this.doctorId,
    required this.creditHours,
    required this.prerequisites,
    required this.registeredStudents,
    required this.sections,
    required this.lectureSessions,
    required this.semester,
    required this.startDate,
    required this.endDate,
    required this.department,
    required this.capacity,
    required this.isActive,
    required this.v,
  });

  final String? id;
  final String? name;
  final String? code;
  final String? doctorId;
  final num? creditHours;
  final List<String>? prerequisites;
  final List<String>? registeredStudents;
  final List<SectionEntity>? sections;
  final List<SessionEntity>? lectureSessions;
  final String? semester;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? department;
  final num? capacity;
  final bool? isActive;
  final num? v;
}

class GetCoursesListResponseEntity {
  final List<GetCoursesResponseDm> courses;
  GetCoursesListResponseEntity({required this.courses});
}

class SessionEntity {
  SessionEntity({
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

class SectionEntity {
  SectionEntity({
    required this.sectionId,
    required this.taId,
    required this.capacity,
    required this.registeredStudents,
    required this.sessions,
    required this.isFull,
    required this.id,
  });

  final String? sectionId;
  final String? taId;
  final num? capacity;
  final List<String>? registeredStudents;
  final List<SessionEntity>? sessions;
  final bool? isFull;
  final String? id;
}
