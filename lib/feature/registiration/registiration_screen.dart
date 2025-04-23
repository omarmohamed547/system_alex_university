import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:system_alex_univ/core/utils/app_style.dart';
import 'package:system_alex_univ/core/utils/di/di.dart';
import 'package:system_alex_univ/domain/entites/AvliableCourseStudent_entity.dart';
import 'package:system_alex_univ/feature/home/home_drawer.dart';
import 'package:system_alex_univ/feature/home/homes_screen.dart';
import 'package:system_alex_univ/feature/registiration/cubit/course_card.dart';
import 'package:system_alex_univ/feature/registiration/cubit/registiration_states.dart';
import 'package:system_alex_univ/feature/registiration/cubit/registiration_view_model.dart';

class RegistrationScreen extends StatefulWidget {
  RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  RegistirationnViewModel registirationViewModel =
      getIt<RegistirationnViewModel>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    registirationViewModel.getAvliableCourse();
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        key: _scaffoldKey,
        drawer: SizedBox(
          width: 260.w,
          child: Drawer(
            child: HomeDrawer(onClose: () {}),
          ),
        ),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                alignment: Alignment.topLeft,
                children: [
                  Container(
                    width: double.infinity,
                    height: 300.h,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.blueAccent, Colors.white],
                        begin: Alignment.topRight,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Center(
                      child: Text("Registration",
                          style: AppStyle.white16Inter.copyWith(fontSize: 36)),
                    ),
                  ),
                  Positioned(
                    top: 50,
                    left: 20,
                    child: ShowHomeDrawer(scaffoldKey: _scaffoldKey),
                  )
                ],
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.only(left: 16.w, right: 24.w, bottom: 16.h),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(width: 1, color: Color(0xff83B8FD)),
                        ),
                        width: 145.w,
                        height: 36.h,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: DropdownButton<String>(
                            value: "Fourthyear",
                            isExpanded: true,
                            items: ["Fourthyear"].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {},
                            underline: SizedBox(),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border:
                              Border.all(width: 1, color: Color(0xff83B8FD)),
                        ),
                        width: 135.w,
                        height: 36.h,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: DropdownButton<String>(
                            value: "Sort A-Z",
                            isExpanded: true,
                            items: ["Sort A-Z"].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {},
                            underline: SizedBox(),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Text("0", style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            BlocBuilder<RegistirationnViewModel, RegistirationState>(
              bloc: registirationViewModel..getAvliableCourse(),
              builder: (context, state) {
                if (state is FailureGetAvaliableCourse) {
                  return SliverToBoxAdapter(
                      child: Text(state.error.errorMessage));
                } else if (state is SucessGetAvaliableCourse) {
                  final courses =
                      state.avaliableCoursesForStudentEntity.courses;

                  String getFormattedDate(String? day) {
                    if (day == null || day.isEmpty) return "N/A";
                    Map<String, String> daysMap = {
                      "Monday": "Mon",
                      "Tuesday": "Tue",
                      "Wednesday": "Wed",
                      "Thursday": "Thu",
                      "Friday": "Fri",
                      "Saturday": "Sat",
                      "Sunday": "Sun",
                    };
                    return daysMap[day] ?? day;
                  }

                  if (courses == null || courses.isEmpty) {
                    return const SliverToBoxAdapter(
                      child: Center(child: Text("No Courses Available")),
                    );
                  }

                  return SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final course = courses[index];

                        final secAppointment = (course.sections != null &&
                                course.sections!.isNotEmpty &&
                                course.sections![0].sessions != null &&
                                course.sections![0].sessions!.isNotEmpty)
                            ? "${getFormattedDate(course.sections![0].sessions![0].day)} ${course.sections![0].sessions![0].startTime ?? ""}"
                            : "N/A";

                        final lecAppointment = (course.lectureSessions !=
                                    null &&
                                course.lectureSessions!.isNotEmpty)
                            ? "${getFormattedDate(course.lectureSessions![0].day)} ${course.lectureSessions![0].startTime ?? ""}"
                            : "N/A";

                        final instructor = course.doctorName ?? "Unknown";
                        final prerequisites = (course.prerequisites != null &&
                                course.prerequisites!.isNotEmpty)
                            ? course.prerequisites![0]
                            : "No prerequisites";

                        final times = <String>[];
                        if (course.sections != null) {
                          for (var section in course.sections!) {
                            if (section.sessions != null) {
                              for (var session in section.sessions!) {
                                final formatted =
                                    "${getFormattedDate(session.day)} ${session.startTime ?? ""}";
                                times.add(formatted);
                              }
                            }
                          }
                        }

                        return CourseCard(
                          isRegisterd: course.isRegistered ?? false,
                          times: times,
                          sections: course.sections ?? [],
                          sectionId: course.sections != null &&
                                  course.sections!.isNotEmpty
                              ? course.sections!.first.sectionId ?? ""
                              : "N/A",
                          courseCode: course.code ?? "",
                          courseName: course.name ?? "",
                          secAppoinement: secAppointment,
                          lecAppoinment: lecAppointment,
                          instructorName: instructor,
                          prerequisites: prerequisites,
                        );
                      },
                      childCount: courses.length,
                    ),
                  );
                } else {
                  return SliverToBoxAdapter(
                    child: Center(
                        child: CircularProgressIndicator(color: Colors.grey)),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
