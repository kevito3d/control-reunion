import 'package:control_reunion/app/data/models/calendar/meeting.dart';
import 'package:control_reunion/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  // List<Meeting> goFromNotification = Get.arguments;
  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    // goFromNotification != null ? Get.toNamed(Routes.MEETING, arguments:{"meetings": goFromNotification, "date": goFromNotification[0].fromDate.toString().split(" ")[0]} ) : print('no');

  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
