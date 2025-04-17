import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:system_alex_univ/core/utils/app_style.dart';
import 'package:system_alex_univ/domain/entites/Course_TimeTable_entity.dart';
import 'package:system_alex_univ/feature/home/cubit/home_state.dart';
import 'package:system_alex_univ/feature/home/cubit/home_view_model.dart';
import 'package:system_alex_univ/feature/home/home_drawer.dart';
import 'package:system_alex_univ/feature/home/homes_screen.dart';
import 'package:system_alex_univ/feature/performance/performance_screen.dart';

class LectureTable extends StatefulWidget {
  @override
  State<LectureTable> createState() => _LectureTableState();
}

class _LectureTableState extends State<LectureTable> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SizedBox(
        width: 260.w,
        child: Drawer(
          child: HomeDrawer(
            onClose: () {},
          ),
        ),
      ),
      body: Column(
        children: [
          TitleScreenWithDrawer(
            scaffoldKey: _scaffoldKey,
            title: "Lecture Table",
          ),
          Expanded(
            child: BlocBuilder<HomeViewModel, HomeState>(
              bloc: HomeViewModel.get(context)..getTimeTable(),
              builder: (context, state) {
                if (state is LoadingGettimeTable) {
                  return Center(
                      child: CircularProgressIndicator(color: Colors.grey));
                }

                if (state is FailureGettimeTable) {
                  return Center(child: Text('Error: ${state.error}'));
                }

                if (state is SucessGettimeTable) {
                  final timetable = state.courseTableEntity.timetable;

                  if (timetable == null) {
                    return Center(child: Text("No timetable data available"));
                  }

                  final List<MapEntry<String, List<DayEntity>?>> days = [
                    MapEntry('SAT', timetable.saturday),
                    MapEntry('SUN', timetable.sunday),
                    MapEntry('MON', timetable.monday),
                    MapEntry('TUE', timetable.tuesday),
                    MapEntry('WED', timetable.wednesday),
                    MapEntry('THU', timetable.thursday),
                    MapEntry('FRI', timetable.friday),
                  ];

                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              /// Time header row
                              Container(
                                color: Color(0xff83B8FD),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 175.w,
                                      child:
                                          Container(), // Empty cell for day column
                                    ),
                                    ..._timeSlots.map(_timeHeader),
                                  ],
                                ),
                              ),

                              /// Lecture table
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.h),
                                child: Table(
                                  border: TableBorder(
                                    horizontalInside: BorderSide(
                                        color: Colors.grey.shade300, width: 1),
                                    verticalInside: BorderSide(
                                        color: Colors.grey.shade300, width: 1),
                                  ),
                                  defaultColumnWidth: FixedColumnWidth(175.w),
                                  children: [
                                    for (var dayData in days)
                                      _buildLectureRow(
                                          dayData.key, dayData.value),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return Center(child: Text('No lectures available.'));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _timeHeader(String time) {
    return SizedBox(
      width: 175.w,
      height: 50.h,
      child: Center(
        child: Text(
          time,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  TableRow _buildLectureRow(String day, List<DayEntity>? lectures) {
    final Map<String, DayEntity> lectureMap = {};
    for (var lecture in lectures ?? []) {
      if (lecture.startTime != null) {
        lectureMap[lecture.startTime!] = lecture;
      }
    }

    List<Widget> rowCells = [
      SizedBox(
        height: 79.h,
        width: 190.w,
        child: Center(
          child: Text(
            day,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      for (var time in _timeSlots)
        Container(
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.symmetric(vertical: 4),
          child: lectureMap.containsKey(time)
              ? buildLectureCell(lectureMap[time]!)
              : SizedBox(width: 190.w),
        ),
    ];

    return TableRow(children: rowCells);
  }

  Widget buildLectureCell(DayEntity lecture) {
    return SizedBox(
      width: 190.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 4,
                  lecture.name ?? "",
                  style: AppStyle.regular14Black,
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "(${lecture.room})",
                  style: AppStyle.regular14Black.copyWith(
                    color: Color(0xffDE8811),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 4),
          Text(
            lecture.doctorName ?? "",
            style: AppStyle.regular14Black.copyWith(color: Color(0xffDE8811)),
          ),
        ],
      ),
    );
  }
}

final List<String> _timeSlots = [
  '8:30 AM',
  '10:30 AM',
  '12:30 PM',
  '2:30 PM',
  '4:30 PM',
  '6:30 PM',
];
