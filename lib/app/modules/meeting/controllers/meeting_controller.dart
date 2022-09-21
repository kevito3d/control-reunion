import 'package:control_reunion/app/data/models/calendar/meeting.dart';
import 'package:control_reunion/app/data/providers/meeting_provider.dart';
import 'package:control_reunion/app/global_memory.dart';
import 'package:control_reunion/app/modules/calendar/controllers/my_calendar_controller.dart';
import 'package:get/get.dart';

class MeetingController extends GetxController {
  //TODO: Implement MeetingController

  //meeting provider
  MeetingProvider mp = Get.find();

  List<Meeting> metings = Get.arguments['meetings'];
  final meetings = <Meeting>[].obs;
  String date = Get.arguments['date'];

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    meetings.value = metings;
  }

  Future postMeeting({required Meeting meeting}) async {
    final response = await mp.postMeeting(
        meeting: meeting, token: GlobalMemory.to.user!.token!);

    // GlobalMemory.to.meetings.add(response);
    meetings.add(response);
    Get.find<MyCalendarController>().meetings.value.add(response);
    Get.find<MyCalendarController>().meetings.refresh();
    meetings.refresh();
    Get.back();
  }

  Future putMeeting({required Meeting meeting}) async {
    final response = await mp.putMeeting(
        meeting: meeting, token: GlobalMemory.to.user!.token!);

    // GlobalMemory.to.meetings.add(response);

    final index = meetings.indexWhere((element) => element.id == meeting.id);
    meetings[index] = meeting;
    final index2 = Get.find<MyCalendarController>()
        .meetings
        .indexWhere((element) => element.id == meeting.id);
    Get.find<MyCalendarController>().meetings.value[index2] = meeting;
    Get.find<MyCalendarController>().meetings.refresh();
    meetings.refresh();
    Get.back();
  }

  Future deleteMeeting({required String id}) async {
    final response =
        await mp.deleteMeeting(token: GlobalMemory.to.user!.token!, id: id);

    // GlobalMemory.to.meetings.add(response);

    final index = meetings.indexWhere((element) => element.id == id);
    meetings.removeAt(index);
    final index2 = Get.find<MyCalendarController>()
        .meetings
        .indexWhere((element) => element.id == id);
    Get.find<MyCalendarController>().meetings.value.removeAt(index2);
    Get.find<MyCalendarController>().meetings.refresh();
    meetings.refresh();
    Get.back();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
