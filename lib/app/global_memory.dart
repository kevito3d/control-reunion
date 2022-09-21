import 'package:control_reunion/app/data/models/calendar/meeting.dart';
import 'package:control_reunion/app/data/models/user_model.dart';
import 'package:control_reunion/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class GlobalMemory {
  User? user;
  List<Meeting> meetings=[];
  GetStorage box = GetStorage();
  
  

  static GlobalMemory get to => Get.find();

  Future<void> logout() async {
    await box.remove("user");
    user = null;
    Get.offAndToNamed(Routes.LOGIN);
  }

  void setUser(User user) {
    this.user = user;
  }

  User? getUser() {
    return user;
  }
}
