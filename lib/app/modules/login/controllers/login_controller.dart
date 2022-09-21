import 'package:control_reunion/app/data/providers/push_notifications_provider.dart';
import 'package:control_reunion/app/data/providers/user_provider.dart';
import 'package:control_reunion/app/global_memory.dart';
import 'package:control_reunion/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  UserProvider up;
  final isLoadin = false.obs;
  //constuctor
  LoginController({required this.up});

  //find global memory
  final gm = Get.find<GlobalMemory>();

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> login({required String usuario, required String clave}) async {
    // await 2.delay();
    print("datos en controller: $usuario : $clave");
    try {
      isLoadin.value = true;
      final user = await up.login(
          user: usuario,
          password: clave,
          tokenPush: PushNotificationService.token!);
      // if(resultado["token"]!=null)
      print(user);
      if (user.id != null) {
        // si tiene id es porque si encontro el user
        await gm.box.write("user", user.toJson());
        isLoadin.value = false;
        Get.offAllNamed(Routes.SPLASH);
      } else {
        isLoadin.value = false;
        Get.snackbar("Error", user.token!,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            borderRadius: 10,
            margin: const EdgeInsets.all(10),
            icon: const Icon(
              Icons.error,
              color: Colors.white,
            ));
      }
    } catch (e) {
      isLoadin.value = false;
      Get.snackbar("Error", e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          borderRadius: 10,
          margin: const EdgeInsets.all(10),
          icon: const Icon(
            Icons.error,
            color: Colors.white,
          ));
      print("error del controller: $e");
    }
  }

  @override
  void onClose() {}
}
