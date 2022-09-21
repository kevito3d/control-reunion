import 'package:control_reunion/app/data/models/calendar/meeting.dart';
import 'package:control_reunion/app/data/providers/meeting_provider.dart';
import 'package:control_reunion/app/global_memory.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MyCalendarController extends GetxController {
  //TODO: Implement CalendarController

  final viewSelected = 3.obs;
  final meetings = <Meeting>[].obs;
  final controllerCallendar = CalendarController();

  MeetingProvider mp;
  //constuctor
  MyCalendarController({required this.mp});

  @override
  void onInit() {
    // meetings.value = [
    //   Meeting(
    //       title: 'Meeting',
    //       description: 'Meeting with John',
    //       fromDate: DateTime.now(),
    //       fromTime: TimeOfDay(hour: 0, minute: 0),
    //       toTime: TimeOfDay(hour: 1, minute: 0),
    //       background: Colors.blue),
    //   Meeting(
    //       title: 'Meeting 2',
    //       description: 'Meeting with Juan',
    //       fromDate: DateTime.now(),
    //       fromTime: TimeOfDay(hour: 1, minute: 30),
    //       toTime: TimeOfDay(hour: 3, minute: 0),
    //       background: Colors.green,)

    // ];
    super.onInit();
    meetings.value = GlobalMemory.to.meetings;
    print(meetings);
  }

  

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
}
