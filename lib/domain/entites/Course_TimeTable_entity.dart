class CourseTableEntity {
  CourseTableEntity({
    required this.message,
    required this.timetable,
  });

  final String? message;
  final TimetableEntity? timetable;
}

class TimetableEntity {
  TimetableEntity(
      {required this.wednesday,
      required this.saturday,
      required this.monday,
      required this.tuesday,
      required this.sunday,
      required this.thursday,
      required this.friday});

  final List<DayEntity>? wednesday;
  final List<DayEntity>? saturday;
  final List<DayEntity>? monday;
  final List<DayEntity>? tuesday;
  final List<DayEntity>? sunday;
  final List<DayEntity>? thursday;
  final List<DayEntity>? friday;
}

class DayEntity {
  DayEntity({
    required this.type,
    required this.name,
    required this.code,
    required this.room,
    required this.startTime,
    required this.endTime,
    required this.doctorName,
    required this.teachingAssistant,
    required this.sectionId,
  });

  final String? type;
  final String? name;
  final String? code;
  final String? room;
  final String? startTime;
  final String? endTime;
  final String? doctorName;
  final String? teachingAssistant;
  final String? sectionId;
}
