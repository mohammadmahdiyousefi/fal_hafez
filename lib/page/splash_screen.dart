import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fal_hafez/model/store_intent.dart';
import 'package:fal_hafez/page/home_screen.dart';
import 'package:fal_hafez/service/app_rate.dart';
import 'package:fal_hafez/service/notificaition_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:tapsell_plus/tapsell_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _initApp() async {
    await _rateApp();
    await _initAds();
    await _initFirebase();
    await _initNotification();
    await _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );
  }

  Future<void> _initAds() async {
    await TapsellPlus.instance.setGDPRConsent(true);
  }

  Future<void> _initFirebase() async {
    try {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyDU3xfmluG2WPReQ-T1dHkayiILWZdenR4',
          appId: '1:699966353645:android:042c54cc63dbb77f9d5ce4',
          messagingSenderId: '699966353645',
          projectId: 'fal-hafez-6f98c',
          storageBucket: 'fal-hafez-6f98c.firebasestorage.app',
        ),
      );
      await _getTokenFirebase();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _initNotification() async {
    try {
      await LocalNotifications.init();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    try {
      await _handelNotificaition();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> _handelNotificaition() async {
    final RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      await _processNotification(initialMessage);
    }

    FirebaseMessaging.onMessage.listen((event) async {
      final Uint8List? image = await _getNotificaitionImage(
        event.notification?.android?.imageUrl,
      );
      await LocalNotifications.showSimpleNotification(
        title: event.notification?.title ?? 'فال حافظ',
        body: event.notification?.body ?? '',
        payload: jsonEncode(event.data),
        image: image,
      );
    });
    FirebaseMessaging.onMessageOpenedApp.listen((event) async {
      await _processNotification(event);
    });
  }

  Future<void> _processNotification(RemoteMessage? message) async {
    if (message == null) return;
    try {
      if (message.data['type'] == 'ads') {
        final Uri url = Uri.parse(message.data['url']);
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        }
      } else if (message.data['type'] == 'update') {
        final String downloadUrl = StoreIntent.falHafezUrl;
        final Uri url = Uri.parse(downloadUrl);
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        } else {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error processing notification: $e");
      }
    }
  }

  Future<void> _getTokenFirebase() async {
    final message = FirebaseMessaging.instance;
    try {
      final String? token = await message.getToken();
      if (token != null) {
        if (kDebugMode) {
          print('Device Token: $token');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching token: $e');
      }
    }
  }

  Future<Uint8List?> _getNotificaitionImage(final String? imageUrl) async {
    if (imageUrl == null) return null;
    try {
      final Dio dio = Dio();
      final Response<Uint8List> response = await dio.get(
        imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );
      final bytes = response.data!;
      return bytes;
    } catch (e) {
      return null;
    }
  }

  Future<void> _rateApp() async {
    try {
      await AppRate.init();
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initApp();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff87562d),
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.asset(
                'assets/images/app_icon.png',
                height: 98,
                width: 98,
              ),
            ),
          ),

          Positioned(
            bottom: 16,
            child: Column(
              children: [
                Text(
                  '...لطفا شکیبا باشید',
                  style: TextStyle(fontFamily: 'lale', color: Colors.white),
                ),
                Gap(8),
                SizedBox(
                  height: 18,
                  width: 18,
                  child: CircularProgressIndicator(color: Color(0xffe4bf92)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
