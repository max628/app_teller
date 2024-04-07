part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const loginScreen = _Paths.loginScreen;
  static const rootScreen = _Paths.rootScreen;
  static const manageCourseScreen = _Paths.manageCourseScreen;
  static const profileScreen = _Paths.profileScreen;
  static const settingsScreen = _Paths.settingsScreen;
}

abstract class _Paths {
  _Paths._();
  static const loginScreen = '/login_screen';
  static const rootScreen = '/root_screen';
  static const manageCourseScreen = '/manage_course_screen';
  static const profileScreen = '/profile_screen';
  static const settingsScreen = '/settings_screen';
}
