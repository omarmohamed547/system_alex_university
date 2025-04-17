import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:system_alex_univ/core/utils/app_style.dart';
import 'package:system_alex_univ/domain/entites/performace_entity.dart';
import 'package:system_alex_univ/feature/home/home_drawer.dart';
import 'package:system_alex_univ/feature/performance/cubit/performance_states.dart';
import 'package:system_alex_univ/feature/performance/cubit/performance_view_model.dart';

class PerformanceScreen extends StatefulWidget {
  PerformanceScreen({super.key});

  @override
  State<PerformanceScreen> createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  List<PassedCourseEntity> _filteredCourses = [];
  @override
  void initState() {
    super.initState();
    context.read<PerformanceViewModel>().getPerformance();
  }

  void _filterCourses(List<PassedCourseEntity> allCourses, String query) {
    if (query.isEmpty) {
      _filteredCourses = allCourses;
    } else {
      _filteredCourses = allCourses
          .where((course) =>
              course.name?.toLowerCase().contains(query.toLowerCase()) ?? false)
          .toList();
    }
    setState(() {});
  }

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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: TitleScreenWithDrawer(
              scaffoldKey: _scaffoldKey,
              title: "Performance",
            ),
          ),
          BlocBuilder<PerformanceViewModel, PerformanceStates>(
            bloc: PerformanceViewModel.get(context),
            builder: (context, state) {
              if (state is FailurePerformanceState) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      'Error: ${state.error.errorMessage}',
                      style: AppStyle.black24Inter.copyWith(color: Colors.red),
                    ),
                  ),
                );
              } else if (state is SuccessPerformanceState) {
                final performance = state.performaceResponseEntity.performance!;
                final allCourses = performance.passedCourses ?? [];

                // Initial population of filteredCourses
                if (_filteredCourses.isEmpty &&
                    _searchController.text.isEmpty) {
                  _filteredCourses = allCourses;
                }

                return _buildPerformanceContent(
                  performance: performance,
                  courses: _filteredCourses,
                  allCourses: allCourses,
                );
              } else {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 50.h),
                      child: CircularProgressIndicator(color: Colors.grey),
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceContent({
    required List<PassedCourseEntity> courses,
    required List<PassedCourseEntity> allCourses,
    required PerformanceEntity performance,
  }) {
    final taken = performance.totalCreditHoursCompleted ?? 0;
    final left = performance.remainingCreditHours ?? 1;
    final cgpa = performance.cgpa ?? 0.0;
    final year = performance.academicLevel ?? '';
    final maxHours = performance.maxAllowedCreditHours ?? 0;

    return SliverList(
      delegate: SliverChildListDelegate([
        // Top Summary UI
        Container(
          width: double.infinity,
          height: 276.h,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey.withOpacity(0.6)),
            borderRadius: BorderRadius.circular(22),
            color: Colors.white,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 16.h),
                        Text("Education Hours",
                            style:
                                AppStyle.black24Inter.copyWith(fontSize: 18)),
                        SizedBox(height: 16.h),
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.w),
                              child: SizedBox(
                                height: 145.h,
                                width: 145.w,
                                child: CircularProgressIndicator(
                                  value: taken / (taken + left),
                                  strokeWidth: 8,
                                  backgroundColor: Colors.grey,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Color(0xff83B8FD)),
                                ),
                              ),
                            ),
                            const Icon(Icons.person,
                                color: Color(0xff83B8FD), size: 40),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.circle,
                                color: Color(0xff83B8FD), size: 12),
                            SizedBox(width: 4),
                            Text("Taken ${taken}H",
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            SizedBox(width: 16),
                            Icon(Icons.circle, color: Colors.grey, size: 12),
                            SizedBox(width: 4),
                            Text("Left ${left}H",
                                style: TextStyle(fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 40.h),
                        Text("Year", style: AppStyle.extraBold14Blue),
                        Text(year,
                            style: AppStyle.bold38Black.copyWith(fontSize: 13)),
                        SizedBox(height: 16.h),
                        Text("CGPA", style: AppStyle.extraBold14Blue),
                        Text("$cgpa",
                            style: AppStyle.bold38Black.copyWith(fontSize: 13)),
                        SizedBox(height: 16.h),
                        Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Hours\n',
                                  style: AppStyle.extraBold14Blue,
                                ),
                                TextSpan(
                                  text: 'registered',
                                  style: AppStyle.extraBold14Blue,
                                ),
                              ],
                            ),
                            textAlign: TextAlign.end,
                          ),
                        ),
                        Text("$maxHours",
                            textAlign: TextAlign.end,
                            style: AppStyle.bold38Black.copyWith(fontSize: 13)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 8.h),
        // Filter and Search bar
        Container(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 12.w),
          child: Row(
            children: [
              Expanded(
                flex: 2,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: Color(0xffF2F2F2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {},
                  icon: Icon(Icons.filter_alt_outlined, color: Colors.grey),
                  label: Text("Filter",
                      style: TextStyle(
                          color: Color(0xff807A7A),
                          fontWeight: FontWeight.w500,
                          fontSize: 12)),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                flex: 4,
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffF2F2F2),
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search, color: Colors.grey),
                    hintStyle: TextStyle(
                        color: Color(0xff807A7A),
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                    contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (text) {
                    _filterCourses(allCourses, text);
                  },
                ),
              ),
            ],
          ),
        ),
        // Table Headers
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          color: Color(0xffF2F2F2),
          child: Row(
            children: [
              Expanded(
                  flex: 3, child: Text("Name ⬍", style: _tableTextStyle())),
              Expanded(
                  flex: 2, child: Text("Hours ⬍", style: _tableTextStyle())),
              Expanded(
                  flex: 2, child: Text("Grade ⬍", style: _tableTextStyle())),
              Expanded(
                  flex: 2, child: Text("Midterm ⬍", style: _tableTextStyle())),
            ],
          ),
        ),
        SizedBox(height: 8.h),
        // Course List
        ...courses.map(
          (course) => Padding(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: PerformanceSubjItem(passedCourseEntity: course),
          ),
        ),
        SizedBox(height: 16.h),
      ]),
    );
  }

  TextStyle _tableTextStyle() => AppStyle.regular14Black.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 12,
        color: Color(0xff404040),
      );
}

class PerformanceSubjItem extends StatelessWidget {
  final PassedCourseEntity passedCourseEntity;
  const PerformanceSubjItem({
    required this.passedCourseEntity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Color(0xffF2F2F2),
      ),
      child: Row(
        children: [
          Expanded(
              flex: 3,
              child: Text(
                passedCourseEntity.name ?? "",
                maxLines: 3,
                style: AppStyle.regular14Black
                    .copyWith(fontSize: 12, color: Color(0xff404040)),
              )),
          Expanded(
              flex: 2,
              child: Text(
                "${passedCourseEntity.creditHours}",
                style: AppStyle.regular14Black.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Color(0xff404040)),
              )),
          Expanded(
              flex: 2,
              child: Text(
                passedCourseEntity.grade ?? "",
                style: AppStyle.regular14Black.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Color(0xff404040)),
              )),
          Expanded(
              flex: 2,
              child: Text(
                "${passedCourseEntity.score}",
                style: AppStyle.regular14Black.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: Color(0xff404040)),
              )),
        ],
      ),
    );
  }
}
