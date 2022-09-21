import 'package:get/get.dart';

import '../controllers/people_meeting_controller.dart';

class PeopleMeetingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PeopleMeetingController>(
      () => PeopleMeetingController(),
    );
  }
}
