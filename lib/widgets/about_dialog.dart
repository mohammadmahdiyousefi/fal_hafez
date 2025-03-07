import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:package_info_plus/package_info_plus.dart';

Future<Widget?> aboutDialog(final BuildContext context) async {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Color(0xffe4bf92),

        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/app_icon.png'),

            FutureBuilder(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final PackageInfo packageInfo = snapshot.data as PackageInfo;
                  return Text(
                    'نسخه ${packageInfo.version}',
                    style: TextStyle(fontFamily: 'lale'),
                  );
                } else {
                  return const Text('نسخه ناشناخته');
                }
              },
            ),
            Gap(16),
            Text(
              'این اپلیکیشن شامل فال های حافظ میباشد و کاربرانی که اعتقاد و باور دارند میتوانند از این اپلیکیشن استفاده کنند .\n (این اپلیکیشن جهت سرگرمی طراحی شده است)',
              textDirection: TextDirection.rtl,
              style: TextStyle(fontFamily: 'lale'),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'بستن',
              style: TextStyle(fontFamily: 'lale', color: Colors.black),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
