import 'package:fal_hafez/constans/string_constns.dart';
import 'package:flutter/foundation.dart';
import 'package:tapsell_plus/tapsell_plus.dart';

class TapsellRewardedAd {
  const TapsellRewardedAd._();
  static bool isRewardedAdLoading = false;
  static Future<void> showRewardedAd({
    final dynamic Function(Map<String, String>)? onClosed,
    final dynamic Function(Map<String, String>)? onRewarded,
    final dynamic Function(Map<String, String>)? onError,
    final dynamic Function(Map<String, String>)? onOpened,
  }) async {
    if (isRewardedAdLoading) return;
    try {
      isRewardedAdLoading = true;
      final String preloadedRewardedId = await TapsellPlus.instance
          .requestRewardedVideoAd(StringConstants.rewardAdZoneId);
      await TapsellPlus.instance.showRewardedVideoAd(
        preloadedRewardedId,
        onOpened: (opened) {
          isRewardedAdLoading = false;
          if (onOpened != null) {
            onOpened(opened);
          }
        },
        onClosed: onClosed,
        onRewarded: onRewarded,
        onError: (error) {
          isRewardedAdLoading = false;
          if (kDebugMode) {
            print("onError Rewarded Ad: $error");
          }
          if (onError != null) {
            onError(error);
          }
        },
      );
    } catch (e) {
      isRewardedAdLoading = false;
      if (kDebugMode) {
        print("Catch Error Rewarded Ad: $e");
      }
      if (onError != null) {
        onError({'message': 'Unexpected error occurred while loading ad'});
      }
    }
  }
}
