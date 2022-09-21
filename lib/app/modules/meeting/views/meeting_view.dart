import 'package:control_reunion/app/data/models/calendar/meeting.dart';
import 'package:control_reunion/app/global_memory.dart';
import 'package:control_reunion/app/modules/widgets/my_alerts.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/meeting_controller.dart';

class MeetingView extends GetView<MeetingController> {
  DateTime? fromDate;
  TimeOfDay? fromTime;
  TimeOfDay? toTime = TimeOfDay(hour: 2, minute: 0);
  final _formKey = GlobalKey<FormState>();
  //scaffold key
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          controller.date,
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              alertMeeting(
                context: context,
                controller: controller,
                date: DateTime.parse(controller.date),
              );
            },
          ),
        ],
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.meetings.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
                leading: CircleAvatar(child: Icon(Icons.add_alert_sharp)),
                title: Text(
                  controller.meetings[index].title!.capitalize!,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                subtitle: Text(controller.meetings[index].description!,
                    style: TextStyle(fontSize: 18, color: Colors.grey)),
                onTap: () {
                  alertMeeting(
                      context: context,
                      controller: controller,
                      meeting: controller.meetings[index]);
                  // Get.dialog(
                  //   AlertDialog(
                  //     key: Key(controller.metings[index].id.toString()),
                  //     title: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Text(controller.metings[index].title!),
                  //         GlobalMemory.to.user!.role == "admin"
                  //             ? IconButton(
                  //                 icon: Icon(Icons.edit),
                  //                 onPressed: () {
                  //                   editable.value = !editable.value;
                  //                 },
                  //               )
                  //             : SizedBox(),
                  //       ],
                  //     ),
                  //     content:
                  //         //form edit new meeting
                  //         Form(
                  //       key: _formKey,
                  //       child: Column(
                  //         mainAxisSize: MainAxisSize.min,
                  //         children: [
                  //           TextFormField(
                  //             validator: (value) {
                  //               if (value == null || value.isEmpty) {
                  //                 return 'Escriba título del evento';
                  //               }
                  //               return null;
                  //             },
                  //             decoration: InputDecoration(
                  //               labelText: "Titulo",
                  //               hintText: "Titulo",
                  //             ),
                  //             initialValue: controller.metings[index].title,
                  //           ),
                  //           TextFormField(
                  //             validator: (value) {
                  //               if (value == null || value.isEmpty) {
                  //                 return 'Escriba descripción del evento';
                  //               }
                  //               return null;
                  //             },
                  //             decoration: InputDecoration(
                  //               labelText: "Descripcion",
                  //               hintText: "Descripcion",
                  //             ),
                  //             initialValue: controller.metings[index].description,
                  //           ),
                  //           Padding(
                  //             padding: const EdgeInsets.symmetric(vertical: 8.0),
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Text("fecha inicio: "),
                  //                 SizedBox(
                  //                   width: Get.width * 0.30,
                  //                   height: 35,
                  //                   child: GestureDetector(
                  //                     onTap: () async {
                  //                       //if focus keyboar active deactive
                  //                       Get.focusScope!.unfocus();
                  //                       fromDate = await alertSelecDate(context);
                  //                       if (fromDate != null) {
                  //                         String formattedDate =
                  //                             DateFormat('yyyy-MM-dd')
                  //                                 .format(fromDate!);
                  //                         fromDateController.text = formattedDate;
                  //                       }
                  //                     },
                  //                     child: AbsorbPointer(
                  //                         child: TextFormField(
                  //                       controller: fromDateController,
                  //                       decoration: const InputDecoration(
                  //                         // labelStyle: TextStyle(color: Colors.black, fontSize: 15),

                  //                         // isDense: true,
                  //                         fillColor: Colors.white,
                  //                         hintText: 'inicial',
                  //                         hintStyle: TextStyle(
                  //                             color: Colors.black, fontSize: 13),
                  //                         filled: true,
                  //                         enabledBorder: OutlineInputBorder(
                  //                           borderSide: BorderSide(width: 0.0),
                  //                         ),
                  //                         contentPadding: EdgeInsets.only(
                  //                           left: 5.0,
                  //                         ),
                  //                       ),
                  //                     )),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //           Padding(
                  //             padding: const EdgeInsets.symmetric(vertical: 8.0),
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Text("Hora: "),
                  //                 SizedBox(
                  //                   width: Get.width * 0.30,
                  //                   height: 35,
                  //                   child: GestureDetector(
                  //                     onTap: () async {
                  //                       Get.focusScope!.unfocus();
                  //                       fromTime = await alertSelectTime(context);
                  //                       if (fromTime != null) {
                  //                         fromTimeController.text =
                  //                             "${fromTime!.hour}:${fromTime!.minute}";
                  //                       }
                  //                     },
                  //                     child: AbsorbPointer(
                  //                         child: TextFormField(
                  //                       controller: fromTimeController,
                  //                       decoration: const InputDecoration(
                  //                         // labelStyle: TextStyle(color: Colors.black, fontSize: 15),

                  //                         // isDense: true,
                  //                         fillColor: Colors.white,
                  //                         hintText: 'Hora',
                  //                         hintStyle: TextStyle(
                  //                             color: Colors.black, fontSize: 13),
                  //                         filled: true,
                  //                         enabledBorder: OutlineInputBorder(
                  //                           borderSide: BorderSide(width: 0.0),
                  //                         ),
                  //                         contentPadding: EdgeInsets.only(
                  //                           left: 5.0,
                  //                         ),
                  //                       ),
                  //                     )),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //           Padding(
                  //             padding: const EdgeInsets.symmetric(vertical: 8.0),
                  //             child: Row(
                  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 Text("Duración: "),
                  //                 SizedBox(
                  //                   width: Get.width * 0.30,
                  //                   height: 65,
                  //                   child: GestureDetector(
                  //                     onTap: () async {
                  //                       Get.focusScope!.unfocus();
                  //                       final hours = 2.obs;
                  //                       final minutes = 0.obs;
                  //                       await alertSelectHourMinuts(
                  //                           context, hours, minutes);
                  //                       toTimeController.text =
                  //                           "${hours.value}:${minutes.value}";
                  //                     },
                  //                     child: AbsorbPointer(
                  //                         child: TextFormField(
                  //                       controller: toTimeController,
                  //                       decoration: const InputDecoration(
                  //                         // labelStyle: TextStyle(color: Colors.black, fontSize: 15),

                  //                         // isDense: true,
                  //                         fillColor: Colors.white,
                  //                         hintText: 'Duracion',
                  //                         hintStyle: TextStyle(
                  //                             color: Colors.black, fontSize: 13),
                  //                         filled: true,
                  //                         enabledBorder: OutlineInputBorder(
                  //                           borderSide: BorderSide(width: 0.0),
                  //                         ),
                  //                         contentPadding: EdgeInsets.only(
                  //                           left: 5.0,
                  //                         ),
                  //                       ),
                  //                     )),
                  //                   ),
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //     actions: [
                  //       ElevatedButton(
                  //         onPressed: () {
                  //           Get.back();
                  //         },
                  //         child: Text('OK'),
                  //       ),
                  //       Obx(
                  //         () => editable.value
                  //             ? ElevatedButton(
                  //                 onPressed: () {},
                  //                 child: Text('editar'),
                  //                 style: ElevatedButton.styleFrom(
                  //                     primary: Colors.green),
                  //               )
                  //             : SizedBox(),
                  //       )
                  //     ],
                  //   ),
                  // );
                });
          },
        ),
      ),

      // DefaultTabController(
      //   length: controller.metings.length,
      //   child: Column(
      //     children: [
      //       TabBar(
      //           labelColor: Colors.black,
      //           unselectedLabelColor: Colors.grey,
      //           isScrollable: true,
      //           tabs: tabsHeader(controller.metings)),
      //       Expanded(
      //           child: TabBarView(
      //         children: tabsContain(controller.metings),
      //       )),
      //     ],
      //   ),
      // ),
    );
  }

  List<Tab> tabsHeader(List<Meeting> a) {
    final tabs = <Tab>[];
    for (var element in a) {
      tabs.add(Tab(
        // text: element.description,
        // icon: Icon(Icons.delete),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(element.title!),
        ),
      ));
    }
    return tabs;
  }

  List<Widget> tabsContain(List<Meeting> a, bool editable) {
    final tabs = <Widget>[];
    for (var element in a) {
      final fromDateController = TextEditingController(
          text: DateFormat('yyyy-MM-dd').format(element.fromDate!));
      final fromTimeController = TextEditingController(
          text: '${element.fromTime!.hour}:${element.fromTime!.minute}');
      final toTimeController = TextEditingController(
          text: "${element.toTime!.hour}:${element.toTime!.minute}");
      AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(element.title!),
            GlobalMemory.to.user!.role == "admin"
                ? IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      editable = true;
                    },
                  )
                : SizedBox(),
          ],
        ),
        content:
            //form edit new meeting
            Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Escriba título del evento';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Titulo",
                  hintText: "Titulo",
                ),
                initialValue: element.title,
              ),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Escriba descripción del evento';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  labelText: "Descripcion",
                  hintText: "Descripcion",
                ),
                initialValue: element.description,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("fecha inicio: "),
                    SizedBox(
                      width: Get.width * 0.30,
                      height: 35,
                      child: GestureDetector(
                        onTap: () async {
                          //if focus keyboar active deactive
                          Get.focusScope!.unfocus();
                          fromDate = await alertSelecDate(Get.context);
                          if (fromDate != null) {
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(fromDate!);
                            fromDateController.text = formattedDate;
                          }
                        },
                        child: AbsorbPointer(
                            child: TextFormField(
                          controller: fromDateController,
                          decoration: const InputDecoration(
                            // labelStyle: TextStyle(color: Colors.black, fontSize: 15),

                            // isDense: true,
                            fillColor: Colors.white,
                            hintText: 'inicial',
                            hintStyle:
                                TextStyle(color: Colors.black, fontSize: 13),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 0.0),
                            ),
                            contentPadding: EdgeInsets.only(
                              left: 5.0,
                            ),
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Hora: "),
                    SizedBox(
                      width: Get.width * 0.30,
                      height: 35,
                      child: GestureDetector(
                        onTap: () async {
                          Get.focusScope!.unfocus();
                          fromTime = await alertSelectTime(Get.context);
                          if (fromTime != null) {
                            fromTimeController.text = fromTime.toString();
                          }
                        },
                        child: AbsorbPointer(
                            child: TextFormField(
                          controller: fromTimeController,
                          decoration: const InputDecoration(
                            // labelStyle: TextStyle(color: Colors.black, fontSize: 15),

                            // isDense: true,
                            fillColor: Colors.white,
                            hintText: 'Hora',
                            hintStyle:
                                TextStyle(color: Colors.black, fontSize: 13),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 0.0),
                            ),
                            contentPadding: EdgeInsets.only(
                              left: 5.0,
                            ),
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Duración: "),
                    SizedBox(
                      width: Get.width * 0.30,
                      height: 65,
                      child: GestureDetector(
                        onTap: () async {
                          Get.focusScope!.unfocus();
                          final hours = 2.obs;
                          final minutes = 0.obs;
                          await alertSelectHourMinuts(
                              Get.context, hours, minutes);
                          toTimeController.text =
                              "${hours.value}:${minutes.value}";
                        },
                        child: AbsorbPointer(
                            child: TextFormField(
                          controller: toTimeController,
                          decoration: const InputDecoration(
                            // labelStyle: TextStyle(color: Colors.black, fontSize: 15),

                            // isDense: true,
                            fillColor: Colors.white,
                            hintText: 'Duracion',
                            hintStyle:
                                TextStyle(color: Colors.black, fontSize: 13),
                            filled: true,
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 0.0),
                            ),
                            contentPadding: EdgeInsets.only(
                              left: 5.0,
                            ),
                          ),
                        )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            child: Text('OK'),
          ),
          ElevatedButton(
            onPressed: () {},
            child: Text('editar'),
            style: ElevatedButton.styleFrom(primary: Colors.green),
          )
        ],
      );
    }
    return tabs;
  }
}
