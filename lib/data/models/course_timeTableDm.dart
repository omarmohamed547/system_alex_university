import 'package:system_alex_univ/domain/entites/Course_TimeTable_entity.dart';

class CourseTableDm extends CourseTableEntity {
  CourseTableDm({
    super.message,
    super.timetable,
  });

  factory CourseTableDm.fromJson(Map<String, dynamic> json) {
    return CourseTableDm(
      message: json["message"],
      timetable: json["timetable"] == null
          ? null
          : TimetableDm.fromJson(json["timetable"]),
    );
  }
}

class TimetableDm extends TimetableEntity {
  TimetableDm({
    super.wednesday,
    super.saturday,
    super.monday,
    super.tuesday,
  });

  factory TimetableDm.fromJson(Map<String, dynamic> json) {
    return TimetableDm(
      wednesday: json["Wednesday"] == null
          ? []
          : List<DayDm>.from(json["Wednesday"]!.map((x) => DayDm.fromJson(x))),
      saturday: json["Saturday"] == null
          ? []
          : List<DayDm>.from(json["Saturday"]!.map((x) => DayDm.fromJson(x))),
      monday: json["Monday"] == null
          ? []
          : List<DayDm>.from(json["Monday"]!.map((x) => DayDm.fromJson(x))),
      tuesday: json["Tuesday"] == null
          ? []
          : List<DayDm>.from(json["Tuesday"]!.map((x) => DayDm.fromJson(x))),
    );
  }
}

class DayDm extends DayEntity {
  DayDm({
    super.type,
    super.name,
    super.code,
    super.room,
    super.startTime,
    super.endTime,
    super.doctorName,
    super.teachingAssistant,
    super.sectionId,
  });

  factory DayDm.fromJson(Map<String, dynamic> json) {
    return DayDm(
      type: json["type"],
      name: json["name"],
      code: json["code"],
      room: json["room"],
      startTime: json["startTime"],
      endTime: json["endTime"],
      doctorName: json["doctorName"],
      teachingAssistant: json["teachingAssistant"],
      sectionId: json["sectionId"],
    );
  }
}
