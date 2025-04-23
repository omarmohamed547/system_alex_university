import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:system_alex_univ/feature/home/home_drawer.dart';

class GPACalculator extends StatefulWidget {
  const GPACalculator({super.key});

  @override
  State<GPACalculator> createState() => _GPACalculatorState();
}

class _GPACalculatorState extends State<GPACalculator> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final List<Course> _courses = [];

  double _gpa = 0.0;

  final Map<String, double> _gradeValues = {
    'A+': 4.0,
    'A': 4.0,
    'A-': 3.7,
    'B+': 3.3,
    'B': 3.0,
    'B-': 2.7,
    'C+': 2.3,
    'C': 2.0,
    'C-': 1.7,
    'D+': 1.3,
    'D': 1.0,
    'F': 0.0,
  };

  void _calculateGPA() {
    double totalQualityPoints = 0;
    int totalCredits = 0;

    for (var course in _courses) {
      if (course.name.isEmpty || course.grade.isEmpty) continue;

      final gradeValue = _gradeValues[course.grade] ?? 0;
      totalQualityPoints += gradeValue * course.credits;
      totalCredits += course.credits;
    }

    setState(() {
      _gpa = totalCredits > 0 ? totalQualityPoints / totalCredits : 0;
    });
  }

  void _addCourse() {
    setState(() {
      _courses.add(Course(name: '', credits: 3, grade: 'B'));
    });
  }

  void _removeCourse(int index) {
    setState(() {
      _courses.removeAt(index);
      _calculateGPA();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleScreenWithDrawer(
                icon: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 32,
                    )),
                title: "GPA calculator",
                scaffoldKey: _scaffoldKey),
            ..._courses.asMap().entries.map((entry) {
              final index = entry.key;
              final course = entry.value;
              return _buildCourseRow(index, course);
            }).toList(),
            const SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: ElevatedButton(
                      onPressed: _calculateGPA,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff8ABCFD),
                      ),
                      child: const Text('Calculate',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff8ABCFD),
                      ),
                      onPressed: _addCourse,
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text('Results:',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 28,
                            fontWeight: FontWeight.bold)),
                  ),
                  Text(
                    _gpa.toStringAsFixed(5),
                    style: TextStyle(
                        color: Color(0xffDE8811),
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseRow(int index, Course course) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Course name',
            ),
            onChanged: (value) {
              setState(() {
                _courses[index].name = value;
              });
            },
            // controller: TextEditingController(text: course.name),
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: DropdownButtonFormField<int>(
                  value: course.credits,
                  items: List.generate(3, (i) => i + 1)
                      .map((credit) => DropdownMenuItem(
                            value: credit,
                            child: Text('$credit'),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _courses[index].credits = value;
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Credits',
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                flex: 1,
                child: DropdownButtonFormField<String>(
                  value: course.grade,
                  items: _gradeValues.keys
                      .map((grade) => DropdownMenuItem(
                            value: grade,
                            child: Text(grade),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      setState(() {
                        _courses[index].grade = value;
                      });
                    }
                  },
                  decoration: const InputDecoration(
                    labelText: 'Grade',
                    hintText: 'Ex:B-',
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: () => _removeCourse(index),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

class Course {
  String name;
  int credits;
  String grade;

  Course({
    required this.name,
    required this.credits,
    required this.grade,
  });
}
