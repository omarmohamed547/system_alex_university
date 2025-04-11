import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:system_alex_univ/core/utils/app_style.dart';
import 'package:system_alex_univ/core/utils/di/di.dart';
import 'package:system_alex_univ/domain/entites/Course_TimeTable_entity.dart';
import 'package:system_alex_univ/feature/home/AnouncmentsItem.dart';
import 'package:system_alex_univ/feature/home/cubit/home_state.dart';
import 'package:system_alex_univ/feature/home/cubit/home_view_model.dart';
import 'package:system_alex_univ/feature/home/home_drawer.dart';
import 'package:intl/intl.dart';
import 'package:system_alex_univ/feature/home/scedule_item.dart';

class HomesScreen extends StatefulWidget {
  HomesScreen({super.key});

  @override
  State<HomesScreen> createState() => _HomesScreenState();
}

class _HomesScreenState extends State<HomesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeViewModel.get(context).getTimeTable();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, // Set Scaffold key

      drawer: SizedBox(
        width: 260.w,
        child: Drawer(
          child: HomeDrawer(
            onClose: () {},
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Image.asset(
                    width: double.infinity,
                    height: 500.h,
                    fit: BoxFit.cover,
                    "assets/images/Vector 2 (1).png"),
                Image.asset(
                  "assets/images/logo_alex_univ.png",
                  height: 123.h,
                  width: 188.w,
                ),
                Positioned(
                  bottom: 54,
                  right: -26,
                  child: Image.asset(
                    "assets/images/avatar.png",
                    height: 350.h,
                    width: 230.w,
                  ),
                ),
                Positioned(
                  top: 120,
                  left: 55,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome,",
                        style: AppStyle.regular24PacificoBlack,
                      ),
                      Text(
                        "Omar Mohamed",
                        style: AppStyle.regular24PacificoBlack
                            .copyWith(fontSize: 32),
                      )
                    ],
                  ),
                ),
                Positioned(
                    top: 90,
                    left: 20,
                    child: ShowHomeDrawer(scaffoldKey: _scaffoldKey)),
                Positioned(
                  bottom: 100,
                  left: 20,
                  child: Text(
                    getFormattedDate(), // Displays "WED. 27"

                    style: GoogleFonts.inter(
                        color: Color(0xff8A8787),
                        fontWeight: FontWeight.w500,
                        fontSize: 24),
                  ),
                ),
                Positioned(
                  left: 20,
                  top: 320,
                  child: Row(
                    children: [
                      Text(
                        "My Schedule:",
                        style: AppStyle.black24Inter,
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Text(
                        "See more",
                        style: AppStyle.black24Inter
                            .copyWith(fontSize: 12, color: Color(0xffFF8000)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 180.h,
              child: BlocBuilder<HomeViewModel, HomeState>(
                builder: (context, state) {
                  if (state is FailureGettimeTable) {
                    return Center(child: Text(state.error.errorMessage));
                  } else if (state is SucessGettimeTable) {
                    final timetable = state.courseTableEntity.timetable;
                    print(state.courseTableEntity.timetable);

// Check if timetable is null or if all days are empty
                    if (timetable == null ||
                        (timetable.sunday?.isEmpty ?? true) &&
                            (timetable.monday?.isEmpty ?? true) &&
                            (timetable.tuesday?.isEmpty ?? true) &&
                            (timetable.wednesday?.isEmpty ?? true) &&
                            (timetable.thursday?.isEmpty ?? true) &&
                            (timetable.saturday?.isEmpty ?? true)) {
                      return Center(child: Text("No timetable data available"));
                    }

// Collect lectures from available days
                    final allLectures = [
                      if (timetable.monday?.isNotEmpty ?? false)
                        ...timetable.monday!,
                      if (timetable.sunday?.isNotEmpty ?? false)
                        ...timetable.sunday!,
                      if (timetable.thursday?.isNotEmpty ?? false)
                        ...timetable.thursday!,
                      if (timetable.tuesday?.isNotEmpty ?? false)
                        ...timetable.tuesday!,
                      if (timetable.wednesday?.isNotEmpty ?? false)
                        ...timetable.wednesday!,
                      if (timetable.saturday?.isNotEmpty ?? false)
                        ...timetable.saturday!,
                    ];

// Check if allLectures is still empty
                    if (allLectures.isEmpty) {
                      return Center(child: Text("No lectures available"));
                    }

                    return ListView.builder(
                      itemCount: allLectures.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final lecture = allLectures[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: ScheduleItem(
                            dayEntity: lecture,
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                        child: CircularProgressIndicator(
                      color: Colors.grey,
                    ));
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 40, bottom: 24),
              child: Row(
                children: [
                  Text(
                    "Anouncments:",
                    style: AppStyle.black24Inter,
                  ),
                  SizedBox(
                    width: 16.w,
                  ),
                  Text(
                    "See more",
                    style: AppStyle.black24Inter
                        .copyWith(fontSize: 12, color: Color(0xffFF8000)),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 195.h,
              child: ListView.builder(
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (builder, index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Anouncmentsitem(),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }

  String getFormattedDate() {
    DateTime now = DateTime.now();
    String dayOfWeek = DateFormat('E').format(now).toUpperCase(); // "WED"
    String day = DateFormat('d').format(now); // "27"

    return "$dayOfWeek.$day";
  }
}
