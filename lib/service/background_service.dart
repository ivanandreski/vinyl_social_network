import 'dart:async';
import 'dart:developer';
import 'dart:math';
import 'dart:ui';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vinyl_social_network/api/chat_service.dart';
import 'package:vinyl_social_network/domain/models/message.dart';
import 'package:vinyl_social_network/utils/util_functions.dart';

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
      iosConfiguration: IosConfiguration(
        autoStart: true,
        onForeground: onStart,
        onBackground: onIosBackground,
      ),
      androidConfiguration: AndroidConfiguration(
          onStart: onStart,
          isForegroundMode: false,
          autoStart: true,
          autoStartOnBoot: true));

  service.startService();
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  if (service is AndroidServiceInstance) {
    // service.on('setAsForeground').listen((event) {
    //   service.setAsForegroundService();
    // });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  Timer.periodic(const Duration(seconds: 10), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await isInternetConnectionAvailable()) {
        List<Message> messages = await ChatService.instance.getUnreadMessages();
        if (messages.isNotEmpty) {
          messages.forEach((message) {
            AwesomeNotifications().createNotification(
                content: NotificationContent(
              id: message.senderId,
              title: message.fullName,
              body: message.body,
              channelKey: "key1",
              wakeUpScreen: true,
            ));
          });
        }
      }
    }
  });
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();

  return true;
}
