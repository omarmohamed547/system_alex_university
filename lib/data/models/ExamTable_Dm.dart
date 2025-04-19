import 'package:system_alex_univ/domain/entites/ExamTable_entity.dart';

class ExamTableDm extends ExamTableEntity {
  ExamTableDm({
    super.success,
    super.semester,
    super.exams,
    super.currentDate,
    super.message,
    super.stats,
  });

  factory ExamTableDm.fromJson(Map<String, dynamic> json) {
    return ExamTableDm(
      success: json["success"],
      semester: json["semester"],
      exams: json["exams"] == null
          ? []
          : List<ExamDm>.from(json["exams"]!.map((x) => ExamDm.fromJson(x))),
      currentDate: DateTime.tryParse(json["currentDate"] ?? ""),
      message: json["message"],
      stats: json["stats"] == null ? null : StatsDm.fromJson(json["stats"]),
    );
  }
}

class ExamDm extends ExamEntity {
  ExamDm({
    super.examId,
    super.courseCode,
    super.courseName,
    super.examType,
    super.date,
    super.day,
    super.time,
    super.location,
    super.status,
    super.hasConflict,
  });

  factory ExamDm.fromJson(Map<String, dynamic> json) {
    return ExamDm(
      examId: json["examId"],
      courseCode: json["courseCode"],
      courseName: json["courseName"],
      examType: json["examType"],
      date: DateTime.tryParse(json["date"] ?? ""),
      day: json["day"],
      time: json["time"],
      location: json["location"],
      status: json["status"],
      hasConflict: json["hasConflict"],
    );
  }
}

class StatsDm extends StatsEntity {
  StatsDm({
    super.upcoming,
    super.completed,
    super.conflicts,
  });

  factory StatsDm.fromJson(Map<String, dynamic> json) {
    return StatsDm(
      upcoming: json["upcoming"],
      completed: json["completed"],
      conflicts: json["conflicts"],
    );
  }
}
