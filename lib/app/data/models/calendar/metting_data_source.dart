import 'package:control_reunion/app/data/models/calendar/meeting.dart';
import 'package:flutter/cupertino.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MeetingDataSource extends CalendarDataSource {
  /// Creates a meeting data source, which used to set the appointment
  /// collection to the calendar
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    Meeting meeting = _getMeetingData(index);
    return meeting.fromDate!.add(Duration(hours: meeting.fromTime!.hour, minutes: meeting.fromTime!.minute));
  }

  @override
  DateTime getEndTime(int index) {
    Meeting meeting = _getMeetingData(index);
    return meeting.fromDate!.add(Duration(hours:  meeting.fromTime!.hour+  meeting.toTime!.hour,  minutes:  meeting.fromTime!.minute+meeting.toTime!.minute));
  }

  @override
  String getSubject(int index) {
    return _getMeetingData(index).title!;
  }

  @override
  Color getColor(int index) {
    return _getMeetingData(index).background!;
  }

  @override
  bool isAllDay(int index) {
    return _getMeetingData(index).isAllDay!;
  }

  Meeting _getMeetingData(int index) {
    final dynamic meeting = appointments![index];
    late final Meeting meetingData;
    if (meeting is Meeting) {
      meetingData = meeting;
    }

    return meetingData;
  }
}