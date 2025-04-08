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
  TimetableDm(
      {super.wednesday,
      super.saturday,
      super.friday,
      super.monday,
      super.tuesday,
      super.sunday,
      super.thursday});

  factory TimetableDm.fromJson(Map<String, dynamic> json) {
    return TimetableDm(
      friday: json["Friday"] == null
          ? []
          : List<DayDm>.from(json["Friday"]!.map((x) => DayDm.fromJson(x))),
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
      sunday: json["Sunday"] == null
          ? []
          : List<DayDm>.from(json["Sunday"]!.map((x) => DayDm.fromJson(x))),
      thursday: json["Thursday"] == null
          ? []
          : List<DayDm>.from(json["Thursday"]!.map((x) => DayDm.fromJson(x))),
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
