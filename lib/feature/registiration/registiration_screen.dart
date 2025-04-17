import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:system_alex_univ/core/utils/app_style.dart';
import 'package:system_alex_univ/core/utils/di/di.dart';
import 'package:system_alex_univ/domain/entites/AvliableCourseStudent_entity.dart';
import 'package:system_alex_univ/feature/home/home_drawer.dart';
import 'package:system_alex_univ/feature/home/homes_screen.dart';
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
    return BlocListener<RegistirationnViewModel, RegistirationState>(
      listener: (context, state) {
        if (state is SucessRegisterCourse ||
            state is SucessRegisterSec ||
            state is SucessDropCourse) {
          final message = state is SucessRegisterCourse
              ? state.registerCourseEntity.message
              : state is SucessRegisterSec
                  ? state.registerSectionEntity.message
                  : (state as SucessDropCourse).dropCourseEntity.message;

          _scaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(
              content: Center(
                child: Text(message ?? "", style: AppStyle.medium16Black),
              ),
              duration: Duration(seconds: 2),
            ),
          );
        } else if (state is FailureRegisterCourse ||
            state is FailureRegisterSec ||
            state is FailureDropCourse) {
          final error = (state as dynamic).error.errorMessage;
          _scaffoldMessengerKey.currentState?.showSnackBar(
            SnackBar(
              content: Center(
                child: Text(error, style: AppStyle.medium16Black),
              ),
              duration: Duration(seconds: 2),
            ),
          );
        }
      },
      child: ScaffoldMessenger(
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
                            style:
                                AppStyle.white16Inter.copyWith(fontSize: 36)),
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
                  padding:
                      EdgeInsets.only(left: 16.w, right: 24.w, bottom: 16.h),
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
                          child:
                              Text("0", style: TextStyle(color: Colors.white)),
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
      ),
    );
  }
}

class CourseCard extends StatefulWidget {
  final String courseName;
  final String instructorName;
  final String lecAppoinment;
  final String secAppoinement;
  final String prerequisites;
  final String courseCode;
  final String sectionId;
  final List<SectionStudentEntity> sections;
  final List<String> times;
  final bool isRegisterd;

  CourseCard({
    super.key,
    required this.courseCode,
    required this.sectionId,
    required this.courseName,
    required this.instructorName,
    required this.lecAppoinment,
    required this.prerequisites,
    required this.secAppoinement,
    required this.sections,
    required this.times,
    required this.isRegisterd,
  });

  @override
  State<CourseCard> createState() => _CourseCardState();
}

class _CourseCardState extends State<CourseCard> {
  String? selectedSec;
  String? selectedTime;
  late bool isRegistered;

  @override
  void initState() {
    super.initState();
    isRegistered = widget.isRegisterd;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Stack(
          alignment: Alignment.centerRight,
          children: [
            Container(
              height: 220.h,
              width: 390.w,
              padding: EdgeInsets.only(left: 8.w),
              decoration: BoxDecoration(
                color: Color(0xffFEF9F2),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(16),
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(32),
                ),
                border:
                    Border.all(width: 1, color: Color.fromRGBO(0, 0, 0, 0.25)),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        RotatedBox(
                          quarterTurns: 3,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                  width: 1, color: Color(0xff83B8FD)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 8.h),
                              child: Text(
                                widget.prerequisites,
                                style: TextStyle(color: Colors.orange),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.w),
                        SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 250.w,
                                child: Text(
                                  widget.courseName,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppStyle.bold38Black
                                      .copyWith(fontSize: 20),
                                ),
                              ),
                              SizedBox(height: 12.h),
                              // First Row: Lec and Time
                              Container(
                                width: 250.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Lec Column
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Lec",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.orange,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        SizedBox(
                                          child: Text(
                                            widget.instructorName,
                                            overflow: TextOverflow.ellipsis,
                                            style: AppStyle.regular14Black
                                                .copyWith(fontSize: 12),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Time Column
                                    Padding(
                                      padding: EdgeInsets.only(right: 42.w),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Time",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.orange,
                                            ),
                                          ),
                                          SizedBox(height: 4.h),
                                          SizedBox(
                                            child: Text(
                                              widget.lecAppoinment,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppStyle.regular14Black
                                                  .copyWith(fontSize: 12),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 16.h),
                              // Second Row: Sec and Time (Dropdowns)
                              Container(
                                width: 250.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Sec Column
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Sec",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.orange,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        ConstrainedBox(
                                          constraints:
                                              BoxConstraints(maxWidth: 130.w),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                                isExpanded: true,
                                                value: widget.sectionId,
                                                hint: Text(
                                                  "Select",
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                items: widget.sections
                                                    .map((section) {
                                                  final secId =
                                                      section.sectionId ??
                                                          "N/A";
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: secId,
                                                    child: Text(
                                                      secId,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: AppStyle
                                                          .regular14Black
                                                          .copyWith(
                                                              fontSize: 12),
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (value) {
                                                  setState(() {
                                                    selectedSec = value;
                                                  });
                                                }),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Time Column
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Time",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.orange,
                                          ),
                                        ),
                                        SizedBox(height: 4.h),
                                        ConstrainedBox(
                                          constraints:
                                              BoxConstraints(maxWidth: 120.w),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton<String>(
                                              isExpanded: true,
                                              value: selectedTime,
                                              hint: Text(
                                                "Select",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.grey,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              items: widget.times.map((time) {
                                                return DropdownMenuItem<String>(
                                                  value: time,
                                                  child: Text(
                                                    time,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: AppStyle
                                                        .regular14Black
                                                        .copyWith(fontSize: 12),
                                                  ),
                                                );
                                              }).toList(),
                                              onChanged: (value) {
                                                setState(() {
                                                  selectedTime = value;
                                                });
                                                if (selectedSec != null) {}
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: InkWell(
                onTap: () {
                  setState(() {
                    isRegistered = !isRegistered;
                  });

                  if (isRegistered) {
                    if (selectedSec != null) {
                      RegistirationnViewModel.get(context)
                          .registerCourse(widget.courseCode)
                          .then((courseResult) {
                        if (courseResult is String) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(courseResult)),
                          );
                          setState(() {
                            isRegistered = false;
                          });
                        } else {
                          RegistirationnViewModel.get(context)
                              .registerSection(widget.courseCode, selectedSec!)
                              .then((sectionResult) {
                            if (sectionResult is String) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(sectionResult)),
                              );
                              setState(() {
                                isRegistered = false;
                              });
                            }
                          });
                        }
                      });
                    } else {
                      RegistirationnViewModel.get(context)
                          .registerCourse(widget.courseCode)
                          .then((courseResult) {
                        if (courseResult is String) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(courseResult)),
                          );
                          setState(() {
                            isRegistered = false;
                          });
                        }
                      });
                    }
                  } else {
                    RegistirationnViewModel.get(context)
                        .dropCourse(widget.courseCode)
                        .then((dropResult) {
                      if (dropResult is String) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(dropResult)),
                        );
                        setState(() {
                          isRegistered = true;
                        });
                      }
                    });
                  }
                },
                borderRadius: BorderRadius.circular(16),
                child: Container(
                  width: 53.w,
                  height: 220.h,
                  decoration: BoxDecoration(
                    color: isRegistered ? Colors.green : Color(0xff83B8FD),
                    borderRadius: BorderRadius.circular(16),
                    gradient: isRegistered
                        ? null
                        : LinearGradient(
                            colors: [
                              Color(0xff83B8FD),
                              Color(0xff5E9FF5),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                  ),
                  child: Center(
                    child: Icon(
                      isRegistered ? Icons.remove : Icons.add,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
