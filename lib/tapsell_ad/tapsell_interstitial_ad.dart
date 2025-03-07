import 'package:fal_hafez/constans/string_constns.dart';
import 'package:flutter/foundation.dart';
import 'package:tapsell_plus/tapsell_plus.dart';

class TapsellInterstitialAd {
  const TapsellInterstitialAd._();
  static bool isInterstitialAdLoading = false;
  static Future<void> showInterstitialAd({
    final dynamic Function(Map<String, String>)? onClosed,
    final dynamic Function(Map<String, String>)? onError,
    final dynamic Function(Map<String, String>)? onOpened,
  }) async {
    if (isInterstitialAdLoading) return;
    try {
      isInterstitialAdLoading = true;
      final String preloadedInterstitialId = await TapsellPlus.instance
          .requestInterstitialAd(StringConstants.interstitialAdZoneId);
      await TapsellPlus.instance.showInterstitialAd(
        preloadedInterstitialId,
        onOpened: (opened) {
          isInterstitialAdLoading = false;
          if (onOpened != null) {
            onOpened(opened);
          }
        },
        onClosed: onClosed,
        onError: (error) {
          isInterstitialAdLoading = false;
          if (kDebugMode) {
            print("onError Interstitial Ad: $error");
          }
          if (onError != null) {
            onError(error);
          }
        },
      );
    } catch (e) {
      isInterstitialAdLoading = false;
      if (kDebugMode) {
        print("Catch Error Interstitial Ad: $e");
      }
      if (onError != null) {
        onError({'message': 'Unexpected error occurred while loading ad'});
      }
    }
  }
}
