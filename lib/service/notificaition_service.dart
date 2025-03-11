import 'dart:convert';
import 'package:fal_hafez/model/store_intent.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:url_launcher/url_launcher.dart';

class LocalNotifications {
  static final FlutterLocalNotificationsPlugin
  _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // initialize the local notifications
  static Future init() async {
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_launcher_foreground');
    const DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings();
    const LinuxInitializationSettings initializationSettingsLinux =
        LinuxInitializationSettings(defaultActionName: 'Open notification');
    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsDarwin,
          linux: initializationSettingsLinux,
        );

    // request notification permissions
    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()!
        .requestNotificationsPermission();

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTap,
      onDidReceiveBackgroundNotificationResponse: _onNotificationTap,
    );
  }

  // on tap on any notification
  static void _onNotificationTap(
    NotificationResponse notificationResponse,
  ) async {
    if (notificationResponse.payload != null) {
      final Map<String, dynamic> event = jsonDecode(
        notificationResponse.payload ?? '{}',
      );
      if (event['type'] == 'ads') {
        final Uri url = Uri.parse(event['url']);
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        }
      } else if (event['type'] == 'update') {
        final String downloadUrl = StoreIntent.falHafezUrl;
        final Uri url = Uri.parse(downloadUrl);
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        }
      }
    }
  }

  // show a simple notification
  static Future showSimpleNotification({
    required final String title,
    required final String body,
    required final String payload,
    final Uint8List? image,
  }) async {
    StyleInformation? styleInformation;
    AndroidBitmap<Object>? largeIcon;
    if (image != null) {
      styleInformation = BigPictureStyleInformation(
        ByteArrayAndroidBitmap(image),
        hideExpandedLargeIcon: true,
        largeIcon: ByteArrayAndroidBitmap(image),
      );
      largeIcon = ByteArrayAndroidBitmap(image);
    }

    final AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'fal_hafez',
          'Fal Hafez',
          channelDescription: 'فال حافظ',
          importance: Importance.max,
          priority: Priority.high,
          styleInformation: styleInformation,
          largeIcon: largeIcon,
          icon: '@drawable/ic_launcher_foreground',
        );
    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );
    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }

  // close a specific channel notification
  static Future cancel(int id) async {
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  // close all the notifications available
  static Future cancelAll() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}
