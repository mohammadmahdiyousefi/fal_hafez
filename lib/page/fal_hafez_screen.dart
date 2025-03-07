import 'package:fal_hafez/bloc/fal_hafez_bloc/fal_hafez_bloc.dart';
import 'package:fal_hafez/di/di.dart';
import 'package:fal_hafez/page/result_fal_hafez_screen.dart';
import 'package:fal_hafez/tapsell_ad/tapsell_interstitial_ad.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class FalHafezScreen extends StatelessWidget {
  const FalHafezScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff87562d),
      appBar: AppBar(
        title: Text(
          'فال حافظ',
          style: TextStyle(fontFamily: 'lale', color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color(0xff87562d),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Image.asset(
                'assets/images/hafez_profile.png',
                height: 248,
                width: 248,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'فال حافظ یکی از رسوم کهن ایرانی است که مردم برای گرفتن الهام و راهنمایی در لحظات خاص از دیوان اشعار حافظ شیرازی استفاده می‌کنند. ایرانیان باور دارند که اشعار حافظ سرشار از حکمت و رمز و راز است و می‌تواند پاسخگوی نیت و دل‌مشغولی‌هایشان باشد.',
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'lale',
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
            Gap(24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                "ای حافظ شیرازی ،تو محرم هر رازی. تورا به شاخ نباتت قسم می دهم که هرچه صلاح است آشکارساز.",
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'lale',
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            Gap(24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffe4bf92),
                foregroundColor: Colors.black,
              ),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder:
                        (context) => BlocProvider(
                          create: (context) {
                            final FalHafezBloc falHafezBloc =
                                locator.get<FalHafezBloc>();
                            falHafezBloc.add(FalHafezGetEvent());
                            return falHafezBloc;
                          },
                          child: ResultFalHafezScreen(),
                        ),
                  ),
                );
                await TapsellInterstitialAd.showInterstitialAd();
              },
              child: Text(
                'نیت کرده سپس کلیک کنید',
                style: TextStyle(
                  fontFamily: 'lale',
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
