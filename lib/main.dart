import 'package:control_reunion/app/data/providers/meeting_provider.dart';
import 'package:control_reunion/app/data/providers/push_notifications_provider.dart';
import 'package:control_reunion/app/data/providers/user_provider.dart';
import 'package:control_reunion/app/global_memory.dart';
import 'package:control_reunion/app/services/local_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

import 'app/routes/app_pages.dart';

void main() async {
  
  await GetStorage.init();
  Get.put(GlobalMemory());
  Get.put(UserProvider());
  Get.put(MeetingProvider());
  //navigator key
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
    //nos aseguramos de que exista un context
  WidgetsFlutterBinding.ensureInitialized();
  await PushNotificationService.initializeApp();

   PushNotificationService.messageStream.listen(((message) {
        debugPrint('message main: ${message.data!}');
       /*  LocalNotification.showNotification(
            title: message.notification!.title!,
            body: message.data!['date'],
           ); */
        Get.toNamed(Routes.SPLASH, arguments: message.data);
          
        

    }));
  runApp(
    GetMaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        SfGlobalLocalizations.delegate
      ],
      supportedLocales: const [
        Locale('es', 'ES'),
        Locale('en', 'US'),
        // ... other locales the app supports
      ],
      navigatorKey: navigatorKey,
      locale: const Locale('es'),
      debugShowCheckedModeBanner: false,
      title: "Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
