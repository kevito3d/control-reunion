import 'package:control_reunion/app/data/models/calendar/meeting.dart';
import 'package:control_reunion/app/global_memory.dart';
import 'package:control_reunion/app/modules/calendar/controllers/my_calendar_controller.dart';
import 'package:control_reunion/app/modules/meeting/controllers/meeting_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:intl/intl.dart';

alertSelecDate(context) async {
  DateTime date = DateTime.now();
  return showDialog(
    context: context,
    builder: (context) => DatePickerDialog(
      initialDate: date,
      firstDate: DateTime(date.year - 5),
      lastDate: DateTime(date.year + 5),
    ),
  );
}

alertSelectTime(context) async {
  TimeOfDay time = TimeOfDay.now();
  return showTimePicker(
    context: context,
    initialTime: time,
  );
}

alertSelectHourMinuts(context, RxInt hours, RxInt minutes) async {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => AlertDialog(
      actions: [
        ElevatedButton(
          onPressed: () => Get.back(),
          child: Text("Aceptar"),
        ),
      ],
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(
            () => NumberPicker(
              value: hours.value,
              minValue: 0,
              maxValue: 23,
              step: 1,
              itemHeight: 50,
              axis: Axis.vertical,
              onChanged: (value) => hours.value = value,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black26),
              ),
            ),
          ),
          SizedBox(width: 5),
          Text(":"),
          SizedBox(width: 5),
          Obx(
            () => NumberPicker(
              value: minutes.value,
              minValue: 0,
              maxValue: 59,
              step: 5,
              itemHeight: 50,
              axis: Axis.vertical,
              onChanged: (value) => minutes.value = value,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black26),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

alertMeeting(
    {required context,
    DateTime? date,
    Meeting? meeting,
    MeetingController? controller}) async {
  final editable = false.obs;
  DateTime? fromDate;
  TimeOfDay? fromTime;
  TimeOfDay? toTime = meeting == null
      ? TimeOfDay(hour: 2, minute: 0)
      : TimeOfDay(hour: meeting.toTime!.hour, minute: meeting.toTime!.minute);

  final fromDateController = TextEditingController(
      text: date != null
          ? DateFormat('yyyy-MM-dd').format(date)
          : DateFormat('yyyy-MM-dd').format(meeting!.fromDate!));
  final fromTimeController = TextEditingController(
      text: date != null
          ? '${date.hour}:${date.minute}'
          : '${meeting!.fromTime!.hour}:${meeting.fromTime!.minute}');
  final toTimeController =
      TextEditingController(text: '${toTime.hour}:${toTime.minute}');
  final titleController =
      TextEditingController(text: meeting != null ? meeting.title : "");
  final descriptionController =
      TextEditingController(text: meeting != null ? meeting.description : "");
  final _formKey = GlobalKey<FormState>();
  var textStyle =
      TextStyle(fontSize: 20, color: Color.fromARGB(255, 93, 93, 93));
  var textStyle2 = TextStyle(fontSize: 20);
  return Get.dialog(AlertDialog(
    title: meeting == null || GlobalMemory.to.user!.role == "admin"
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(meeting == null ? "Crear Evento" : "Editar Evento"),
              meeting != null && GlobalMemory.to.user!.role == "admin"
                  ? Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            controller!.deleteMeeting(id: meeting.id!);
                          },
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                        ),
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            editable.value = !editable.value;
                          },
                        ),
                      ],
                    )
                  : SizedBox(),
            ],
          )
        : SizedBox(),
    content:
        //form edit new meeting
        meeting == null || GlobalMemory.to.user!.role == "admin"
            ? Form(
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
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: "Titulo",
                        hintText: "Titulo",
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Escriba descripción del evento';
                        }
                        return null;
                      },
                      controller: descriptionController,
                      decoration: InputDecoration(
                        labelText: "Descripcion",
                        hintText: "Descripcion",
                      ),
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
                                Get.focusScope!.unfocus();
                                fromDate = await alertSelecDate(context);
                                if (fromDate != null) {
                                  String formattedDate =
                                      DateFormat('yyyy-MM-dd')
                                          .format(fromDate!);
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
                                  hintText: 'Fecha',
                                  hintStyle: TextStyle(
                                      color: Colors.black, fontSize: 13),
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
                                fromTime = await alertSelectTime(context);
                                if (fromTime != null) {
                                  fromTimeController.text =
                                      "${fromTime!.hour}:${fromTime!.minute}";
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
                                  hintStyle: TextStyle(
                                      color: Colors.black, fontSize: 13),
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
                                    context, hours, minutes);
                                toTimeController.text =
                                    "${hours.value}:${minutes.value}";
                              },
                              child: AbsorbPointer(
                                  child: TextFormField(
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'selecione una duracion del evento';
                                  }
                                  return null;
                                },
                                controller: toTimeController,
                                decoration: const InputDecoration(
                                  // labelStyle: TextStyle(color: Colors.black, fontSize: 15),

                                  // isDense: true,
                                  fillColor: Colors.white,
                                  hintText: 'Duracion',
                                  hintStyle: TextStyle(
                                      color: Colors.black, fontSize: 13),
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
              )
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "${meeting.title}",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${meeting.description}",
                    style: textStyle,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Fecha: ",
                        style: textStyle2,
                      ),
                      Text(
                        meeting.fromDate.toString().split(" ")[0],
                        style: textStyle,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Hora: ",
                        style: textStyle2,
                      ),
                      Text(
                        "${meeting.fromTime!.hour}:${meeting.fromTime!.minute}",
                        style: textStyle,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Duración: ",
                        style: textStyle2,
                      ),
                      Text(
                        "${meeting.toTime!.hour}:${meeting.toTime!.minute}",
                        style: textStyle,
                      ),
                    ],
                  ),
                ],
              ),
    actions: [
      ElevatedButton(
        onPressed: () => Get.back(),
        child: Text('Ok'),
        // style: ElevatedButton.styleFrom(
        //   primary: Colors.red,
        // ),
      ),
      meeting == null || GlobalMemory.to.user!.role == "admin"
          ? Obx(
              () => editable.value || meeting == null
                  ? ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          List<String> fromdate =
                              fromDateController.text.toString().split('-');
                          List<String> fromtime =
                              fromTimeController.text.toString().split(':');
                          meeting == null
                              ? controller!.postMeeting(
                                  meeting: Meeting(
                                    title: titleController.text,
                                    description: descriptionController.text,
                                    fromDate: DateTime(
                                        int.parse(fromdate[0]),
                                        int.parse(fromdate[1]),
                                        int.parse(fromdate[2])),
                                    fromTime: TimeOfDay(
                                        hour: int.parse(fromtime[0]),
                                        minute: int.parse(fromtime[1])),
                                    toTime: TimeOfDay(
                                      hour: int.parse(toTimeController.text
                                          .toString()
                                          .split(':')[0]),
                                      minute: int.parse(toTimeController.text
                                          .toString()
                                          .split(':')[1]),
                                    ),
                                  ),
                                )
                              : controller!.putMeeting(
                                  meeting: Meeting(
                                    id: meeting.id,
                                    title: titleController.text,
                                    description: descriptionController.text,
                                    fromDate: DateTime(
                                        int.parse(fromdate[0]),
                                        int.parse(fromdate[1]),
                                        int.parse(fromdate[2])),
                                    fromTime: TimeOfDay(
                                        hour: int.parse(fromtime[0]),
                                        minute: int.parse(fromtime[1])),
                                    toTime: TimeOfDay(
                                      hour: int.parse(toTimeController.text
                                          .toString()
                                          .split(':')[0]),
                                      minute: int.parse(toTimeController.text
                                          .toString()
                                          .split(':')[1]),
                                    ),
                                  ),
                                );
                        }
                      },
                      child: Text(meeting == null ? 'crear' : "editar"))
                  : SizedBox(),
            )
          : SizedBox(),
    ],
  ));
}
