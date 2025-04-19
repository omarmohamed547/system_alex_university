import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:system_alex_univ/core/utils/app_style.dart';
import 'package:system_alex_univ/core/utils/di/di.dart';
import 'package:system_alex_univ/feature/ExamTable/cubit/examTableViesModel.dart';
import 'package:system_alex_univ/feature/ExamTable/cubit/examtable_states.dart';
import 'package:system_alex_univ/feature/home/home_drawer.dart';

class ExamtableScreen extends StatefulWidget {
  const ExamtableScreen({super.key});

  @override
  State<ExamtableScreen> createState() => _ExamtableScreenState();
}

class _ExamtableScreenState extends State<ExamtableScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime selectedDay = DateTime(2025, 5, 17); // default selected
  late Examtableviesmodel examtableviesmodel;

  @override
  void initState() {
    super.initState();
    // خلّي Bloc هنا ونديه في BlocProvider
    examtableviesmodel = getIt<Examtableviesmodel>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: SizedBox(
        width: 260.w,
        child: Drawer(child: HomeDrawer(onClose: () {})),
      ),
      body: BlocProvider.value(
        value: examtableviesmodel,
        child: Column(
          children: [
            ExamTableTitleScreenWithDrawer(scaffoldKey: _scaffoldKey),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SizedBox(
                height: 90.h,
                child: BlocBuilder<Examtableviesmodel, ExamtableStates>(
                    bloc: examtableviesmodel..getExamTable(),
                    builder: (context, state) {
                      if (state is SucessGetExamTable) {
                        final examList = state.examTableEntity.exams ?? [];

                        final List<DateTime> days = examList
                            .map((exam) => exam.date)
                            .whereType<DateTime>()
                            .toSet()
                            .toList()
                          ..sort((a, b) => a.compareTo(b));

                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: days.length,
                          itemBuilder: (context, index) {
                            final day = days[index];
                            final isSelected = selectedDay.year == day.year &&
                                selectedDay.month == day.month &&
                                selectedDay.day == day.day;

                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedDay = day;
                                });
                              },
                              child: Container(
                                width: 50.w,
                                height: isSelected ? 90.h : 60.h,
                                margin: const EdgeInsets.only(right: 10),
                                decoration: BoxDecoration(
                                  color: isSelected
                                      ? Color.fromRGBO(0, 115, 204, 1)
                                      : Color.fromRGBO(255, 158, 18, 1),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                padding: EdgeInsets.symmetric(vertical: 8.h),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      DateFormat.E().format(day),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      day.day.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      } else if (state is LoadingGetExamTable) {
                        // Show placeholder (e.g., shimmer or grey boxes)
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, index) => Container(
                            width: 50.w,
                            height: 70.h,
                            margin: const EdgeInsets.only(right: 10),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                        );
                      } else {
                        return const SizedBox(); // fallback
                      }
                    }),
              ),
            ),
            Expanded(
              child: BlocBuilder<Examtableviesmodel, ExamtableStates>(
                bloc: examtableviesmodel..getExamTable(),
                builder: (context, state) {
                  if (state is LoadingGetExamTable) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.grey,
                    ));
                  } else if (state is FailureGetExamTable) {
                    return Center(child: Text(state.error.errorMessage));
                  } else if (state is SucessGetExamTable) {
                    final examList = state.examTableEntity.exams ?? [];

                    final examsForSelectedDay = examList
                        .where((exam) =>
                            exam.date?.day == selectedDay.day &&
                            exam.date?.month == selectedDay.month &&
                            exam.date?.year == selectedDay.year)
                        .toList();

                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 24.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.w),
                            child: Text(
                              DateFormat('EEEE, dd MMMM yyyy')
                                  .format(selectedDay),
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(height: 32.h),
                          ...examsForSelectedDay.asMap().entries.map((entry) {
                            final index = entry.key;
                            final exam = entry.value;

                            final tileColor = index % 2 == 0
                                ? Color.fromRGBO(
                                    210, 231, 247, 1) // لون العناصر الزوجية
                                : Color(0xffFFEFE7); // لون العناصر الفردية

                            final stripeColor = index % 2 == 0
                                ? Color.fromRGBO(
                                    42, 157, 143, 1) // لون العناصر الزوجية
                                : Color(0xffF6945D); // لون العناصر الفردية
                            return Padding(
                              padding: EdgeInsets.only(
                                  bottom: 20.h, left: 16.w, right: 16.w),
                              child: ScheduleTile(
                                stripeColor: stripeColor,
                                time: exam.time ?? 'Unknown Time',
                                title: exam.courseName ?? 'Unknown Course',
                                room: exam.location ?? 'Unknown Room',
                                color: tileColor,
                              ),
                            );
                          }).toList(),
                          if (examsForSelectedDay.isEmpty)
                            Padding(
                              padding: EdgeInsets.all(16.w),
                              child: Center(
                                child: Text(
                                  'No exams on this day.',
                                  style: TextStyle(
                                      fontSize: 16.sp, color: Colors.grey),
                                ),
                              ),
                            ),
                          SizedBox(height: 40.h),
                        ],
                      ),
                    );
                  } else {
                    return const Center(child: Text("Unknown state"));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExamTableTitleScreenWithDrawer extends StatelessWidget {
  const ExamTableTitleScreenWithDrawer({
    super.key,
    required GlobalKey<ScaffoldState> scaffoldKey,
  }) : _scaffoldKey = scaffoldKey;

  final GlobalKey<ScaffoldState> _scaffoldKey;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xff83B8FD), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.9, 1.0],
            ),
          ),
          child: Image.asset(
            fit: BoxFit.cover,
            height: 300.h,
            "assets/images/Rectangle 151.png",
          ),
        ),
        Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Text(
                maxLines: 2,
                "Exam Table",
                style: AppStyle.white16Inter.copyWith(fontSize: 36)),
          ),
        ),
        Positioned(
          top: 50,
          left: 20,
          child: ShowHomeDrawer(scaffoldKey: _scaffoldKey),
        ),
      ],
    );
  }
}

class ScheduleTile extends StatelessWidget {
  final String time;
  final String title;
  final String room;
  final Color color;
  final Color stripeColor;
  const ScheduleTile(
      {super.key,
      required this.time,
      required this.title,
      required this.room,
      required this.color,
      required this.stripeColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 90.w,
          child: Text(
            time,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 90.h,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 4.w,
                  height: 90.h,
                  decoration: BoxDecoration(
                    color: stripeColor,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                SizedBox(width: 12.w),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            style:
                                AppStyle.black24Inter.copyWith(fontSize: 15)),
                        SizedBox(height: 4.h),
                        Text('Room($room)',
                            style:
                                AppStyle.black24Inter.copyWith(fontSize: 15)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
