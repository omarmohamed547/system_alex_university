class ExamTableEntity {
  ExamTableEntity({
    required this.success,
    required this.semester,
    required this.exams,
    required this.currentDate,
    required this.message,
    required this.stats,
  });

  final bool? success;
  final String? semester;
  final List<ExamEntity>? exams;
  final DateTime? currentDate;
  final String? message;
  final StatsEntity? stats;
}

class ExamEntity {
  ExamEntity({
    required this.examId,
    required this.courseCode,
    required this.courseName,
    required this.examType,
    required this.date,
    required this.day,
    required this.time,
    required this.location,
    required this.status,
    required this.hasConflict,
  });

  final String? examId;
  final String? courseCode;
  final String? courseName;
  final String? examType;
  final DateTime? date;
  final String? day;
  final String? time;
  final String? location;
  final String? status;
  final bool? hasConflict;
}

class StatsEntity {
  StatsEntity({
    required this.upcoming,
    required this.completed,
    required this.conflicts,
  });

  final num? upcoming;
  final num? completed;
  final num? conflicts;
}
