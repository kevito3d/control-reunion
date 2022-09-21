import 'package:control_reunion/app/data/models/user_model.dart';
import 'package:control_reunion/app/data/providers/meeting_provider.dart';
import 'package:control_reunion/app/data/providers/push_notifications_provider.dart';
import 'package:control_reunion/app/global_memory.dart';
import 'package:control_reunion/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  //fing gm
  final gm = Get.find<GlobalMemory>();
  var isLoading = true.obs;
  final mp = Get.find<MeetingProvider>();

  dynamic notificacion = Get.arguments;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() async {
    isLoading.value = true;
    await fetchdata();
    super.onReady();
  }

  Future<void> fetchdata() async {
    final user = gm.box.hasData('user')
        ? User.fromJson(await gm.box.read('user'))
        : null;
    if (user == null) {
      Get.offAndToNamed(Routes.LOGIN);
    } else {
      gm.setUser(user);
      try {
        gm.meetings = await mp.getMeetings(token: gm.user!.token!);
        if (notificacion != null) {
          //fitre where frondate
          final meetings = gm.meetings
              .where((element) =>
                  element.fromDate ==
                  DateTime.parse(notificacion['date']))
              .toList();
          Get.offAllNamed(Routes.HOME);
          Get.toNamed(Routes.MEETING, arguments: {"meetings":meetings, "date":notificacion['date']});
        } else {
          Get.offAndToNamed(
            Routes.HOME,
          );
        }
        print(gm.meetings);
      } catch (e) {
        print(e.toString());
      }
    }
  }

  @override
  void onClose() {}
}
