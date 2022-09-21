import 'package:control_reunion/app/data/models/calendar/meeting.dart';
import 'package:control_reunion/app/data/models/user_model.dart';
import 'package:control_reunion/app/helper.dart';
import 'package:get/get.dart';

class MeetingProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.defaultDecoder = (map) {
      if (map["data"] is Map<String, dynamic>) {
        return Meeting.fromJson(map["data"]);
      }
      if (map["data"] is List) {
        return map["data"].map((item) => Meeting.fromJson(item)).toList();
      }
    };

    httpClient.baseUrl = baseurl;
  }

  //login
  Future<Meeting> postMeeting(
      {required Meeting meeting, required String token}) async {
    print("lo que me esta llegando al provider:${meeting.title}");

    // create body for send request
    final response = await post("meeting", meeting.toJson(), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'x-access-token': token
    });

    return meeting;
  }

  Future<Meeting> putMeeting(
      {required Meeting meeting,
      required String token,
      }) async {
    print("lo que me esta llegando al provider:${meeting.title}");

    // create body for send request

    final response = await put("meeting", meeting.toJson(), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'x-access-token': token
    });
    // if (response.isOk) {
      return meeting;
    // } else {
    //   throw Exception('Failed to load album');
    // }

  }

  Future<bool> deleteMeeting(
      {
      required String token,
      required String id}) async {

    // create body for send request

    final response = await delete("meeting/$id", headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'x-access-token': token
    });
    // if (response.isOk) {
      return true;
    // } else {
    //   throw Exception('Failed to load album');
    // }

  }

  //get all meetings
  Future<List<Meeting>> getMeetings({required String token}) async {
    final response = await get('meeting', headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'x-access-token': token
    });
    var data = response.body.cast<Meeting>();
    return data;
  }

  Future<Response> deleteUser(int id) async => await delete('meeting/$id');
}
