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
          if (state is SucessRegisterCourse) {
            print(state.registerCourseEntity.message);
            _scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
              content: Center(
                child: Text(
                  state.registerCourseEntity.message ?? "",
                  style: AppStyle.medium16Black,
                ),
              ),
              duration: Duration(seconds: 2), // Show for 2 seconds
            ));

            registirationViewModel.getAvliableCourse();
          } else if (state is FailureRegisterCourse) {
            print(state.error.errorMessage);
            _scaffoldMessengerKey.currentState?.showSnackBar(SnackBar(
              content: Center(
                child: Text(
                  state.error.errorMessage,
                  style: AppStyle.medium16Black,
                ),
              ),
              duration: Duration(seconds: 2), // Show for 2 seconds
            ));
          }
        },
        child: ScaffoldMessenger(
          key: _scaffoldMessengerKey, // Use the ScaffoldMessenger key
          child: Scaffold(
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
                Stack(
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
                        child: ShowHomeDrawer(scaffoldKey: _scaffoldKey))
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.w, right: 24.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(width: 1, color: Color(0xff83B8FD))),
                        width: 145.w,
                        height: 36.h,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: DropdownButton<String>(
                            value: "Fourthyear",
                            items: ["Fourthyear"].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {},
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border:
                                Border.all(width: 1, color: Color(0xff83B8FD))),
                        width: 135.w,
                        height: 36.h,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: DropdownButton<String>(
                            value: "Sort A-Z",
                            items: ["Sort A-Z"].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {},
                          ),
                        ),
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.green,
                        child: Text("0", style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child:
                      BlocBuilder<RegistirationnViewModel, RegistirationState>(
                    bloc: registirationViewModel..getAvliableCourse(),
                    builder: (context, state) {
                      print("Current State: $state");

                      if (state is FailureGetCourseByDoctor) {
                        return Text(state.error.errorMessage);
                      } else if (state is SucessGetCourseByDoctor) {
                        String getFormattedDate(String? day) {
                          if (day == null || day.isEmpty)
                            return "N/A"; // Handle null or empty case

                          Map<String, String> daysMap = {
                            "Monday": "Mon",
                            "Tuesday": "Tue",
                            "Wednesday": "Wed",
                            "Thursday": "Thu",
                            "Friday": "Fri",
                            "Saturday": "Sat",
                            "Sunday": "Sun",
                          };

                          return daysMap[day] ??
                              day; // Return formatted day or original if not found
                        }

                        return state.avaliableCoursesForStudentEntity.courses ==
                                    null ||
                                state.avaliableCoursesForStudentEntity.courses!
                                    .isEmpty
                            ? const Center(child: Text("No Courses Available"))
                            : ListView.builder(
                                padding: EdgeInsets.zero,
                                itemCount: state
                                    .avaliableCoursesForStudentEntity
                                    .courses!
                                    .length,
                                itemBuilder: (context, index) {
                                  final course = state
                                      .avaliableCoursesForStudentEntity
                                      .courses![index];

                                  final secAppointment = (course.sections !=
                                              null &&
                                          course.sections!.isNotEmpty &&
                                          course.sections![0].sessions !=
                                              null &&
                                          course.sections![0].sessions!
                                              .isNotEmpty)
                                      ? "${getFormattedDate(course.sections![0].sessions![0].day)} ${course.sections![0].sessions![0].startTime ?? ""}"
                                      : "N/A";

                                  final lecAppointment = (course
                                                  .lectureSessions !=
                                              null &&
                                          course.lectureSessions!.isNotEmpty)
                                      ? "${getFormattedDate(course.lectureSessions![0].day)} ${course.lectureSessions![0].startTime ?? ""}"
                                      : "N/A";

                                  final instructor =
                                      course.doctorName ?? "Unknown";
                                  final prerequisites =
                                      (course.prerequisites != null &&
                                              course.prerequisites!.isNotEmpty)
                                          ? course.prerequisites![0]
                                          : "No prerequisites";

                                  return CourseCard(
                                    courseCode: course.code ?? "",
                                    courseName: course.name ?? "",
                                    secAppoinement: secAppointment,
                                    lecAppoinment: lecAppointment,
                                    instructorName: instructor,
                                    prerequisites: prerequisites,
                                  );
                                },
                              );
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.grey,
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class CourseCard extends StatelessWidget {
  String courseName;
  String instructorName;
  String lecAppoinment;
  String secAppoinement;
  String prerequisites;
  String courseCode;
  // final bool isRegistered;
  CourseCard(
      {super.key,
      //  required this.isRegistered,
      required this.courseCode,
      required this.courseName,
      required this.instructorName,
      required this.lecAppoinment,
      required this.prerequisites,
      required this.secAppoinement});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 220.h,
        width: 390.w,
        padding: EdgeInsets.only(left: 8.w),
        margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 12.h),
        decoration: BoxDecoration(
            color: Color(0xffFEF9F2),
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(16),
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(32)),
            border: Border.all(width: 1, color: Color.fromRGBO(0, 0, 0, 0.25))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                RotatedBox(
                  quarterTurns: 3,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(width: 1, color: Color(0xff83B8FD))),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                      child: Text(prerequisites,
                          style: TextStyle(color: Colors.orange)),
                    ),
                  ),
                ),
                SizedBox(
                  width: 16.w,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 250.w, // Or a specific width like 200.0
                      child: Text(
                        courseName,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppStyle.bold38Black.copyWith(fontSize: 24),
                      ),
                    ),
                    SizedBox(
                      width: 12.h,
                    ),
                    Text(instructorName, style: AppStyle.regular14Black),
                    SizedBox(
                      height: 12.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .center, // Align text to the start

                          children: [
                            Text("Lec", style: TextStyle(color: Colors.orange)),
                            Text(lecAppoinment,
                                style: TextStyle(color: Colors.orange)),
                          ],
                        ),
                        SizedBox(
                          width: 24.w,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment
                              .center, // Align text to the start

                          children: [
                            Text("Sec", style: TextStyle(color: Colors.orange)),
                            Text(secAppoinement,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.orange)),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            /* isRegistered
                ? InkWell(
                    onTap: () {
                      RegistirationnViewModel.get(context)
                          .registerCourse(courseCode);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffDE7D7D),
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(12),
                            topRight: Radius.circular(12)),
                      ),
                      width: 70.w,
                      height: double.infinity,
                      child: const Icon(
                        Icons.remove,
                        color: Colors.white,
                        size: 42,
                      ),
                    ),
                  )
                : */
            InkWell(
              onTap: () {
                RegistirationnViewModel.get(context).registerCourse(courseCode);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff83B8FD),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(12),
                      topRight: Radius.circular(12)),
                ),
                width: 70.w,
                height: double.infinity,
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 42,
                ),
              ),
            ),
          ],
        ));
  }
}
