import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:system_alex_univ/core/utils/app_style.dart';
import 'package:system_alex_univ/domain/entites/AvliableCourseStudent_entity.dart';
import 'package:system_alex_univ/feature/registiration/cubit/registiration_view_model.dart';

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

  const CourseCard({
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
  bool isRegistered = false;
  bool isLoading = false;
  String? errorMessage;
  String? registrationError; // For course registration errors
  String? sectionWarning; // For section-specific warnings

  @override
  void initState() {
    super.initState();
    isRegistered = widget.isRegisterd;
    _loadInitialState();
  }

  Future<void> _loadInitialState() async {
    final prefs = await SharedPreferences.getInstance();
    final savedStatus = prefs.getBool('${widget.courseCode}_is_registered');
    final savedSec = prefs.getString('${widget.courseCode}_selected_sec');

    if (mounted) {
      setState(() {
        isRegistered = savedStatus ?? widget.isRegisterd;
        selectedSec = isRegistered ? savedSec : null;
      });
    }
  }

  Future<void> _saveRegistrationStatus(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('${widget.courseCode}_is_registered', status);
  }

  Future<void> _saveSelectedSection(String secId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('${widget.courseCode}_selected_sec', secId);
    if (mounted) setState(() => selectedSec = secId);
  }

  Future<void> _showErrorDialog(String message) async {
    if (!mounted) return;
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Row(
          children: [
            Text("Warning"),
            Icon(
              Icons.warning,
              color: Colors.amber,
            )
          ],
        ),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  Future<void> _handleRegistrationToggle() async {
    setState(() {
      isLoading = true;
      registrationError = null;
      sectionWarning =
          null; // Clear section warnings when toggling registration
    });

    try {
      if (isRegistered) {
        // Drop course logic
        final response = await RegistirationnViewModel.get(context)
            .dropCourse(widget.courseCode);

        if (response is String && !response.toLowerCase().contains('success')) {
          throw Exception('Failed to drop course: $response');
        }

        await _saveRegistrationStatus(false);
        if (mounted) {
          setState(() => isRegistered = false);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Course dropped successfully')),
          );
        }
      } else {
        final response = await RegistirationnViewModel.get(context)
            .registerCourse(widget.courseCode);

        if (response is String) {
          if (response.toLowerCase().contains('conflict')) {
            throw Exception('Time conflict with this course');
          } else if (response
              .contains('Exceeds maximum allowed credit hours (18)')) {
            throw Exception('Exceeds maximum allowed credit hours (18)');
          } else if (!response.toLowerCase().contains('success')) {
            throw Exception(response);
          }
        }

        await _saveRegistrationStatus(true);
        if (mounted) {
          setState(() {
            isRegistered = true;
            registrationError = null;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Course registered successfully')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          registrationError = e.toString();
          isRegistered = false;
        });

        if (e
            .toString()
            .contains('Exceeds maximum allowed credit hours (18)')) {
          await _showErrorDialog(
              'Warning: You have exceeded the maximum allowed credit hours (18).');
        } else if (e.toString().toLowerCase().contains('conflict')) {
          await _showErrorDialog(
              'Warning: Time conflict with this course. Please check your schedule.');
        } else {
          await _showErrorDialog('Registration failed: ${e.toString()}');
        }
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
  }

  Future<void> _handleSectionChange(String newSectionId) async {
    if (newSectionId == selectedSec) return;

    setState(() {
      isLoading = true;
      sectionWarning = null; // Clear previous section warnings
    });

    try {
      if (isRegistered && selectedSec != null) {
        final dropResult = await RegistirationnViewModel.get(context)
            .dropSection(widget.courseCode, selectedSec!);

        if (dropResult is String &&
            !dropResult.toLowerCase().contains('success')) {
          throw Exception('Failed to drop section: $dropResult');
        }
      }

      final response = await RegistirationnViewModel.get(context)
          .registerSection(widget.courseCode, newSectionId);

      if (response is String) {
        if (response.toLowerCase().contains('conflict')) {
          // Set warning but don't unregister course
          setState(() {
            sectionWarning = 'Time conflict with this section';
          });
          await _showErrorDialog(
              'Warning: Time conflict with this section. Please choose another section.');
          return;
        } else if (response.contains('maximum')) {
          // Set warning but don't unregister course
          setState(() {
            sectionWarning = 'Exceeds maximum allowed credit hours (18)';
          });
          await _showErrorDialog(
              'Warning: You have exceeded the maximum allowed credit hours (18).');
          return;
        } else if (!response.toLowerCase().contains('success')) {
          throw Exception(response);
        }
      }

      await _saveSelectedSection(newSectionId);
      if (mounted) {
        setState(() {
          sectionWarning = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Section changed successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          sectionWarning = e.toString();
        });
        await _showErrorDialog(e.toString());
      }
    } finally {
      if (mounted) setState(() => isLoading = false);
    }
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
                color: const Color(0xffFEF9F2),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(16),
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                  bottomLeft: Radius.circular(32),
                ),
                border: Border.all(
                    width: 1, color: const Color.fromRGBO(0, 0, 0, 0.25)),
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
                                  width: 1, color: const Color(0xff83B8FD)),
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 8.w, vertical: 8.h),
                              child: Text(
                                widget.prerequisites,
                                style: const TextStyle(color: Colors.orange),
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
                              SizedBox(
                                width: 250.w,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Text(
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
                                      SizedBox(width: 40.w),
                                      Column(
                                        children: [
                                          const Text(
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
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 16.h),
                              GestureDetector(
                                onTap: () => _showSectionDialog(context),
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.w, vertical: 4.h),
                                  child: Text(
                                    selectedSec ?? "Sec",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: selectedSec != null
                                          ? Colors.black
                                          : Colors.orange,
                                      fontWeight: selectedSec != null
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
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
            _buildRegistrationButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildRegistrationButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: InkWell(
        onTap: isLoading ? null : _handleRegistrationToggle,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 53.w,
          height: 220.h,
          decoration: BoxDecoration(
            color: isRegistered ? Colors.green : const Color(0xff83B8FD),
            borderRadius: BorderRadius.circular(16),
            gradient: isRegistered
                ? null
                : const LinearGradient(
                    colors: [Color(0xff83B8FD), Color(0xff5E9FF5)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
          ),
          child: Center(
            child: isLoading
                ? const CircularProgressIndicator(color: Colors.white)
                : Icon(
                    isRegistered ? Icons.remove : Icons.add,
                    color: Colors.white,
                    size: 32,
                  ),
          ),
        ),
      ),
    );
  }

  Future<void> _showSectionDialog(BuildContext context) async {
    if (!isRegistered) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please register the course first')),
        );
      }
      return;
    }

    String formatSectionTime(SectionStudentEntity section) {
      if (section.sessions == null || section.sessions!.isEmpty) {
        return section.sectionId ?? "N/A";
      }

      // Get all unique session times
      final times = section.sessions!
          .map((s) => '${s.startTime}-${s.endTime}')
          .toSet() // Remove duplicates
          .join(', ');

      return "${section.sectionId} ($times)";
    }

    await showDialog(
      context: context,
      builder: (dialogContext) {
        String? dialogSelectedSec = selectedSec;
        bool isProcessing = false;

        return StatefulBuilder(
          builder: (context, dialogSetState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      widget.courseName,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Divider(height: 30),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Available sections",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                    DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        isExpanded: true,
                        value: isProcessing ? null : dialogSelectedSec,
                        hint: const Text("Select"),
                        items: widget.sections.map((section) {
                          final secId = section.sectionId ?? "N/A";
                          final isSelected = secId == dialogSelectedSec;
                          return DropdownMenuItem<String>(
                            // Use the sectionId as the value to ensure uniqueness
                            value: secId,
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 4),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    formatSectionTime(section),
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isSelected
                                          ? Colors.blue
                                          : Colors.black,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: isProcessing
                            ? null
                            : (value) {
                                dialogSetState(() {
                                  dialogSelectedSec = value;
                                });
                              },
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: isProcessing || dialogSelectedSec == null
                          ? null
                          : () async {
                              dialogSetState(() => isProcessing = true);
                              await _handleSectionChange(dialogSelectedSec!);
                              if (dialogContext.mounted) {
                                Navigator.of(dialogContext).pop();
                              }
                            },
                      child: isProcessing
                          ? const CircularProgressIndicator()
                          : const Text("Save"),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
