import 'package:control_reunion/app/data/models/calendar/meeting.dart';
import 'package:control_reunion/app/data/models/calendar/metting_data_source.dart';
import 'package:control_reunion/app/global_memory.dart';
import 'package:control_reunion/app/modules/calendar/controllers/my_calendar_controller.dart';
import 'package:control_reunion/app/modules/widgets/my_alerts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MyCalendarView extends GetView<MyCalendarController> {
  final _controller = CalendarController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('CalendarView'),
          centerTitle: true,
          actions: [
            //todo: agregar boton para crear reunion
            IconButton(
                icon: Icon(Icons.add),
                onPressed: () async {
                  await GlobalMemory.to.logout();
                })
          ],
        ),
        body: Column(
          children: [
            Container(
              height: 75,
              color: Colors.red.shade100,
              child: Row(children: [
                Text("vista: "),
                //butondropdown
                Obx(
                  () => DropdownButton(
                    value: controller.viewSelected.value,
                    items: [
                      DropdownMenuItem(
                        child: Text("Day"),
                        value: 0,
                      ),
                      DropdownMenuItem(
                        child: Text("Week"),
                        value: 1,
                      ),
                      // DropdownMenuItem(
                      //   child: Text("WorkWeek"),
                      //   value: 2,
                      // ),
                      DropdownMenuItem(
                        child: Text("Month"),
                        value: 3,
                      ),
                      // DropdownMenuItem(
                      //   child: Text("TimelineDay"),
                      //   value: 4,
                      // ),
                      // DropdownMenuItem(
                      //   child: Text("TimelineWeek"),
                      //   value: 5,
                      // ),
                      // DropdownMenuItem(
                      //   child: Text("TimelineWorkWeek"),
                      //   value: 6,
                      // ),
                      // DropdownMenuItem(
                      //   child: Text("TimelineMonth"),
                      //   value: 7,
                      // ),
                    ],
                    onChanged: (value) {
                      controller.viewSelected.value = value as int;
                      _controller.view = views(controller.viewSelected.value);
                    },
                  ),
                ),
              ]),
            ),
            Expanded(
              child: SfCalendar(
                controller: _controller,
                view: CalendarView.month,

                onTap: (CalendarTapDetails details) {
                  if (details.targetElement == CalendarElement.appointment ||
                      details.appointments != null &&
                          details.appointments!.isNotEmpty) {
                    print(details.appointments![0]);
                    final Meeting meetingDetails = details.appointments![0];

                    Get.dialog(
                      AlertDialog(
                        title: Text(meetingDetails.title!),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(meetingDetails.description!),
                            Text(meetingDetails.fromDate.toString()),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text("OK"),
                          ),
                        ],
                      ),
                    );

                    // ));
                  } else {
                    print("no");
                  }
                },

                dataSource: MeetingDataSource(_getDataSource()),
                // by default the month appointment display mode set as Indicator, we can
                // change the display mode as appointment using the appointment display
                // mode property
                monthViewSettings: const MonthViewSettings(
                    appointmentDisplayMode:
                        MonthAppointmentDisplayMode.appointment),

                //  onLongPress: (CalendarLongPressDetails details) {
                //   print(details.date);
                // },

                // onTap: (CalendarTapDetails details) {
                //   print(details.date);
                // },
              ),
            ),
          ],
        ));
  }

  CalendarView views(int value) {
    switch (value) {
      case 0:
        return CalendarView.day;
      case 1:
        return CalendarView.week;
      // case 2:
      //   return CalendarView.workWeek;
      // case 3:
      //   return CalendarView.month;
      // case 4:
      //   return CalendarView.timelineDay;
      // case 5:
      //   return CalendarView.timelineWeek;
      // case 6:
      //   return CalendarView.timelineWorkWeek;
      default:
        // return CalendarView.timelineMonth;
        return CalendarView.month;
    }
  }

  List<Meeting> _getDataSource() {
    final List<Meeting> meetings = <Meeting>[];
    // final List<Appointment> meetings = <Appointment>[];
    final DateTime today = DateTime.now();
    final DateTime startTime = DateTime(
      today.year,
      today.month,
      today.day,
      12,
    );
    final DateTime endTime = startTime.add(const Duration(hours: 2));
    // meetings.add(Meeting(
    //     title: 'Conference',
    //     fromDate: startTime,
    //     description: "en la casa de pepito",
    //     toTime: endTime,
    //     background: const Color(0xFF0F8644),
    //     isAllDay: false));
    // meetings.add(Appointment(
    //   startTime: startTime,
    //   endTime: endTime,
    //   subject: 'Conference',
    //   color: const Color(0xFF0F8644),
    //   isAllDay: false,
    // ));
    return meetings;
  }
}
