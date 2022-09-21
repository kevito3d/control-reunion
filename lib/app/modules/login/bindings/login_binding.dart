import 'package:control_reunion/app/data/providers/meeting_provider.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(up: Get.find()),
    );
  }
}
