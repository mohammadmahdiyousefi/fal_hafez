import 'package:fal_hafez/model/store_intent.dart';
import 'package:fal_hafez/page/fal_hafez_finger_screen.dart';
import 'package:fal_hafez/page/fal_hafez_screen.dart';
import 'package:fal_hafez/service/app_rate.dart';
import 'package:fal_hafez/tapsell_ad/tapsell_native_ad_widget.dart';
import 'package:fal_hafez/widgets/about_dialog.dart';
import 'package:fal_hafez/widgets/commenting_bottomsheet.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _rateApp() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      try {
        final bool value = await AppRate.showRateDialog();
        if (value) {
          await Future.delayed(const Duration(seconds: 3));
          if (mounted) {
            await commentingbottomsheet(context);
          }
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _rateApp();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Color(0xff87562d),
        appBar: AppBar(
          title: Text(
            format1(Jalali.now()),
            textDirection: TextDirection.rtl,
            style: TextStyle(fontFamily: 'lale', color: Colors.white),
          ),
          backgroundColor: Color(0xff87562d),
        ),
        body: Center(
          child: Column(
            children: [
              Image.asset('assets/images/hafez.png'),
              Expanded(
                child: Container(
                  height: 20,
                  width: double.infinity,
                  color: Color(0xffe4bf92),
                  child: Column(
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Gap(12),
                              SizedBox(
                                width: 320,
                                child: Text(
                                  "ای حافظ شیرازی ،تو محرم هر رازی. تورا به شاخ نباتت قسم می دهم که هرچه صلاح است آشکارساز.",
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontFamily: 'IRNS',
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Gap(24),
                              GestureDetector(
                                onTap:
                                    () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => const FalHafezScreen(),
                                      ),
                                    ),
                                child: Container(
                                  width: double.infinity,
                                  height: 48,
                                  margin: EdgeInsets.symmetric(horizontal: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Color(0xff87562d),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.5,
                                        ),
                                        spreadRadius: 1,
                                        blurRadius: 7,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      'فال حافظ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'lale',
                                        color: Colors.white,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Gap(16),
                              GestureDetector(
                                onTap:
                                    () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) =>
                                                const FalHafezFingerScreen(),
                                      ),
                                    ),
                                child: Container(
                                  width: double.infinity,
                                  height: 48,
                                  margin: EdgeInsets.symmetric(horizontal: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Color(0xff87562d),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.5,
                                        ),
                                        spreadRadius: 1,
                                        blurRadius: 7,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      ' فال با اثر انگشت  ',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'lale',
                                        color: Colors.white,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Gap(16),
                              GestureDetector(
                                onTap: () async {
                                  await aboutDialog(context);
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 48,
                                  margin: EdgeInsets.symmetric(horizontal: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Color(0xff87562d),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.5,
                                        ),
                                        spreadRadius: 1,
                                        blurRadius: 7,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      'درباره ما',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'lale',
                                        color: Colors.white,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Gap(16),
                              GestureDetector(
                                onTap: () async {
                                  if (await canLaunchUrl(
                                    Uri.parse(StoreIntent.storeDeveloperApp),
                                  )) {
                                    await launchUrl(
                                      Uri.parse(StoreIntent.storeDeveloperApp),
                                    );
                                  } else {
                                    await launchUrl(
                                      Uri.parse(StoreIntent.storeDeveloperApp),
                                      mode:
                                          LaunchMode
                                              .externalNonBrowserApplication,
                                    );
                                  }
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 48,
                                  margin: EdgeInsets.symmetric(horizontal: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Color(0xff87562d),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.5,
                                        ),
                                        spreadRadius: 1,
                                        blurRadius: 7,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      'سایر برنامه های ما',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'lale',
                                        color: Colors.white,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Gap(16),
                              GestureDetector(
                                onTap: () async {
                                  await commentingbottomsheet(context);
                                },
                                child: Container(
                                  width: double.infinity,
                                  height: 48,
                                  margin: EdgeInsets.symmetric(horizontal: 16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Color(0xff87562d),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(
                                          alpha: 0.5,
                                        ),
                                        spreadRadius: 1,
                                        blurRadius: 7,
                                        offset: Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      'نظر دادن به برنامه',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontFamily: 'lale',
                                        color: Colors.white,
                                        fontSize: 22,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Gap(16),
                            ],
                          ),
                        ),
                      ),
                      TapsellNativeAdWidget(size: TapsellNativeAdSize.standard),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String format1(Date d) {
    final f = d.formatter;

    return '${f.wN} ${f.d} ${f.mN} ${f.yyyy}';
  }
}
