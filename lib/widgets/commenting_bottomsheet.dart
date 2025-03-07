import 'package:android_intent_plus/android_intent.dart';
import 'package:fal_hafez/constans/string_constns.dart';
import 'package:fal_hafez/model/store_intent.dart';
import 'package:fal_hafez/service/app_rate.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

import 'package:url_launcher/url_launcher.dart';

Future<Widget?> commentingbottomsheet(final BuildContext context) async {
  final String data = StoreIntent.storeData;
  final String pakage = StoreIntent.storePakage;
  final String action = StoreIntent.storeAction;
  return showModalBottomSheet(
    isDismissible: false,
    isScrollControlled: false,
    backgroundColor: Color(0xffe4bf92),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(26),
        topRight: Radius.circular(26),
      ),
    ),
    elevation: 0,
    context: context,
    sheetAnimationStyle: AnimationStyle(
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
      reverseDuration: const Duration(milliseconds: 350),
    ),
    builder: (ctx) {
      return IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
          child: Column(
            children: [
              const Gap(16),
              Text(
                "نظر سنجی",
                style: TextStyle(fontSize: 20, fontFamily: 'lale'),
              ),
              const Gap(16),

              const Gap(16),
              Text(
                "همراه عزیز فال حافظ، لطفا با دادن نظر 5 ستاره از برنامه خود حمایت کنید",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'lale',
                  color: Colors.black,
                ),
              ),
              const Gap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "از برنامه رضایت داری ؟",
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'lale',
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              const Gap(16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff87562d),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  minimumSize: const Size(double.infinity, 46),
                ),
                onPressed: () async {
                  try {
                    final AndroidIntent intent = AndroidIntent(
                      action: action,
                      data: data,
                      package: pakage,
                    );
                    await intent.launch();
                    await AppRate.setRateGiven();
                    if (ctx.mounted) {
                      Navigator.of(ctx).pop();
                    }
                  } catch (e) {
                    if (kDebugMode) {
                      print(e.toString());
                    }
                  }
                },
                child: Text(
                  "آره خوبه 😍",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'lale',
                    color: Colors.white,
                  ),
                ),
              ),
              const Gap(12),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  minimumSize: const Size(double.infinity, 46),
                  side: BorderSide(color: Color(0xff87562d), width: 1.6),
                ),
                onPressed: () async {
                  Navigator.of(ctx).pop();
                  WidgetsBinding.instance.addPostFrameCallback((_) async {
                    if (context.mounted) {
                      await unhappybottomsheet(context);
                    }
                  });
                },
                child: Text(
                  "نه خوب نیست 😔",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'lale',
                    color: Colors.black,
                  ),
                ),
              ),
              const Gap(16),
            ],
          ),
        ),
      );
    },
  );
}

Future<Widget?> unhappybottomsheet(final BuildContext context) async {
  const String email = "mailto:${StringConstants.supportEmail}";
  return showModalBottomSheet(
    isScrollControlled: false,
    isDismissible: false,
    backgroundColor: Color(0xffe4bf92),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(26),
        topRight: Radius.circular(26),
      ),
    ),
    elevation: 0,
    context: context,
    sheetAnimationStyle: AnimationStyle(
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
      reverseDuration: const Duration(milliseconds: 350),
    ),
    builder: (context) {
      return IntrinsicHeight(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Gap(16),
              Text(
                "چقدر بد ! 😔 ممکن انتقادی که داری برا ما بفرستی؟ ",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'lale',
                  color: Colors.black,
                ),
              ),
              const Gap(16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff87562d),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  minimumSize: const Size(double.infinity, 46),
                ),
                onPressed: () async {
                  try {
                    await canLaunchUrl(Uri.parse(email)).then((value) async {
                      if (value) {
                        await launchUrl(Uri.parse(email));
                      } else {
                        await launchUrl(
                          Uri.parse(email),
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    });
                    await AppRate.setRateGiven();
                  } catch (e) {
                    if (kDebugMode) {
                      print(e.toString());
                    }
                  }
                },
                child: Text(
                  "ارسال انتقاد",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'lale',
                    color: Colors.white,
                  ),
                ),
              ),
              const Gap(12),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  minimumSize: const Size(double.infinity, 46),
                  side: BorderSide(color: Color(0xff87562d), width: 1.6),
                ),
                onPressed: () async {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "بازگشت",
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'lale',
                    color: Colors.black,
                  ),
                ),
              ),
              const Gap(16),
            ],
          ),
        ),
      );
    },
  );
}
