import 'package:control_reunion/app/data/models/calendar/meeting.dart';
import 'package:control_reunion/app/data/models/calendar/metting_data_source.dart';
import 'package:control_reunion/app/global_memory.dart';

import 'package:control_reunion/app/modules/calendar/controllers/my_calendar_controller.dart';
import 'package:control_reunion/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MyCalendarAdminView extends GetView<MyCalendarController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CalendarView'),
        centerTitle: true,
        actions: [
          //btn logout
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await GlobalMemory.to.logout();
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "vista: ",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                //butondropdown
                itemsDrop(),
              ],
            ),
            Container(
              height: Get.height * 0.6,
              child: Obx(
                () => SfCalendar(
                  controller: controller.controllerCallendar,
                  view: CalendarView.month,
                  onTap: (CalendarTapDetails details) {
                    // if (details.targetElement == CalendarElement.appointment ||
                    //     details.appointments != null &&
                    //         details.appointments!.isNotEmpty) {
                    //   print(details.appointments![0]);
                    //   final List<Meeting> meetingsDetails =
                    //       details.appointments!.cast();
                    //   //go to route meeting
                    //   Get.toNamed('/meeting', arguments: meetingsDetails);

                    // } else {
                    //   alertMeeting(
                    //       context: context,
                    //       controller: controller,
                    //       date: details.date!);
                    // }
                    final List<Meeting> meetingsDetails =
                        controller.viewSelected.value != 3 // si no es por mes
                            ? controller.meetings.value
                                .where((element) =>
                                    element.fromDate!.year ==
                                        details.date!.year &&
                                    element.fromDate!.month ==
                                        details.date!.month &&
                                    element.fromDate!.day == details.date!.day)
                                .toList()
                            : details.appointments!.cast();
                    //go to route meeting
                    Get.toNamed(Routes.MEETING, arguments: {
                      "meetings": meetingsDetails,
                      "date": details.date.toString().split(" ")[0]
                    });
                  },

                  dataSource: MeetingDataSource(controller.meetings.value),
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
            ),
          ],
        ),
      ),
    );
  }

  Obx itemsDrop() {
    return Obx(
      () => DropdownButton(
        value: controller.viewSelected.value,
        items: [
          DropdownMenuItem(
            child: Text("Diario"),
            value: 0,
          ),
          DropdownMenuItem(
            child: Text("Semanal"),
            value: 1,
          ),
          // DropdownMenuItem(
          //   child: Text("Semana de trabajo"),
          //   value: 2,
          // ),
          DropdownMenuItem(
            child: Text("Mensual"),
            value: 3,
          ),
          // DropdownMenuItem(
          //   child: Text("Cronología del dia"),
          //   value: 4,
          // ),
          // DropdownMenuItem(
          //   child: Text("Cronología Semanal"),
          //   value: 5,
          // ),
          // DropdownMenuItem(
          //   child: Text("Cronología de Trabajo Semanal"),
          //   value: 6,
          // ),
          // DropdownMenuItem(
          //   child: Text("Cronología Mensual"),
          //   value: 7,
          // ),
        ],
        onChanged: (value) {
          controller.viewSelected.value = value as int;
          controller.controllerCallendar.view =
              views(controller.viewSelected.value);
        },
      ),
    );
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
}
