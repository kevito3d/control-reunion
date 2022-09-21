import 'package:control_reunion/app/modules/splash/controllers/splash_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatelessWidget {
  SplashController controller = Get.find<SplashController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        /* decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: gradiantColors)), */
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Control Reunion",
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontSize: 32)),
                  const SizedBox(
                    width: 10,
                  ),
                  /* Logo(
                    logoSize: logoSize,
                  ) */
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 5,
              width: 200,
              child: Obx(
                () => controller.isLoading.value
                    ? const LinearProgressIndicator(
                        color: Colors.green,
                        backgroundColor: Colors.blue,
                      )
                    : SizedBox(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
