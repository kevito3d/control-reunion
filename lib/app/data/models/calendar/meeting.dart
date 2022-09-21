import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:string_to_hex/string_to_hex.dart';

class Meeting {
  /// Creates a meeting class with required details.
  Meeting(
      {this.id,
      this.title,
      this.fromDate,
      this.fromTime,
      this.toTime,
      this.background=Colors.red,
      this.isAllDay=false,
      this.description});

  String? id;

  /// Event name which is equivalent to subject property of [Appointment].
  String? title;

  String? description;

  /// From which is equivalent to start time property of [Appointment].
  DateTime? fromDate;

  TimeOfDay? fromTime;

  /// To which is equivalent to end time property of [Appointment].
  TimeOfDay? toTime;

  /// Background which is equivalent to color property of [Appointment].
  Color? background;

  /// IsAllDay which is equivalent to isAllDay property of [Appointment].
  bool? isAllDay=false;

  /// Metting from json
  Meeting.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    title = json['title'];
    description = json['description'];
    fromDate = DateTime.parse(json['fromDate']);
    fromTime = TimeOfDay(
        hour: int.parse(json["fromTime"]["hora"]),minute:  int.parse(json["fromTime"]["minutos"]));
    // to = DateTime.parse(json['to']);
    toTime =
        TimeOfDay(hour: int.parse(json["toTime"]["hora"]), minute: int.parse(json["toTime"]["minutos"]));
    String _string = StringToHex.toHexString(json['color']);
                 Color generatedColor = Color(StringToHex.toColor(_string));
    
    background = generatedColor;
    isAllDay = json['isAllDay']??false;
  }

  /// Metting to json
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['fromDate'] = fromDate.toString();
    data['fromTime'] = {
      "hora": fromTime!.hour.toString(),
      "minutos": fromTime!.minute.toString(),
    };
    data['toTime'] = {
      "hora": toTime!.hour.toString(),
      "minutos": toTime!.minute.toString(),
    };
    data['color'] = background!.value.toString();
    data['isAllDay'] = isAllDay.toString();
    return data;
  }
}
