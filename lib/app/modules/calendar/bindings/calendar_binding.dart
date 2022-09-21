import 'package:get/get.dart';

import '../controllers/my_calendar_controller.dart';

class CalendarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyCalendarController>(
      () => MyCalendarController(mp: Get.find()),
    );
  }
}
