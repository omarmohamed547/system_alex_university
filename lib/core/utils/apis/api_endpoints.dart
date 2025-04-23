class ApiEndpoints {
  static String loginendpoint = 'api/auth/login';
  static String resetPassendpoint = 'api/auth/reset-password';
  static String forgetPassendpoint = 'api/auth/forgot-password';

  static String getCoursesendpoint = 'api/admin/courses';
  static String getAvliableCourseseStudentndpoint =
      'api/student/available-courses';
  static String registerSectionsStudentndpoint = 'api/student/register-section';

  static String registerCourseseStudentndpoint = 'api/student/register-course';
  static String dropCourseseStudentndpoint = 'api/student/drop-course';
  static String dropSectionStudentndpoint = 'api/student/drop-section';

  static String getCourseseTableendpoint = 'api/student/time-table';
  static String getPerformamceendpoint = 'api/gpa/performance';
  static String getExamTableendpoint = 'api/student/exams';
  static String getprofilepictureendpoint = 'api/auth/get-profile-picture';
}
