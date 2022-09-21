import 'package:control_reunion/app/data/models/calendar/meeting.dart';
import 'package:get/get.dart';

import 'package:control_reunion/app/modules/calendar/bindings/calendar_binding.dart';
import 'package:control_reunion/app/modules/calendar/views/my_calendar_admin_view.dart';
import 'package:control_reunion/app/modules/calendar/views/my_calendar_view.dart';
import 'package:control_reunion/app/modules/home/bindings/home_binding.dart';
import 'package:control_reunion/app/modules/home/views/home_view.dart';
import 'package:control_reunion/app/modules/login/bindings/login_binding.dart';
import 'package:control_reunion/app/modules/login/views/login_view.dart';
import 'package:control_reunion/app/modules/meeting/bindings/meeting_binding.dart';
import 'package:control_reunion/app/modules/meeting/views/meeting_view.dart';
import 'package:control_reunion/app/modules/people-meeting/bindings/people_meeting_binding.dart';
import 'package:control_reunion/app/modules/people-meeting/views/people_meeting_view.dart';
import 'package:control_reunion/app/modules/splash/bindings/splash_binding.dart';
import 'package:control_reunion/app/modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      arguments: Map,
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashScreen(),
      arguments: dynamic,
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.CALENDAR,
      page: () => MyCalendarView(),
      binding: CalendarBinding(),
    ),
    GetPage(
      name: _Paths.CALENDAR_ADMIN,
      page: () => MyCalendarAdminView(),
      binding: CalendarBinding(),
    ),
    GetPage(
      name: _Paths.PEOPLE_MEETING,
      page: () => PeopleMeetingView(),
      binding: PeopleMeetingBinding(),
    ),
    GetPage(
      name: _Paths.MEETING,
      arguments: Map,
      page: () => MeetingView(),
      binding: MeetingBinding(),
    ),
  ];
}
