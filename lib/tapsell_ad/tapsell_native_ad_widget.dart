import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fal_hafez/constans/string_constns.dart';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:gap/gap.dart';
import 'package:tapsell_plus/NativeAdData.dart';
import 'package:tapsell_plus/tapsell_plus.dart';
import 'package:tapsell_plus/NativeAdPayload.dart';

enum TapsellNativeAdSize { standard, large, medium }

class TapsellNativeAdWidget extends StatefulWidget {
  const TapsellNativeAdWidget({super.key, required this.size});
  final TapsellNativeAdSize size;
  @override
  State<TapsellNativeAdWidget> createState() => _TapsellNativeAdWidgetState();
}

class _TapsellNativeAdWidgetState extends State<TapsellNativeAdWidget> {
  String? _adId;
  NativeAdData? _adData;
  StreamSubscription? _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _checkInternetAndRequestAd();
    _listenToInternetChanges();
  }

  void _checkInternetAndRequestAd() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none) == false) {
      await _requestAd();
    }
  }

  void _listenToInternetChanges() {
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      result,
    ) async {
      if (result.contains(ConnectivityResult.none) == false && _adId == null) {
        await _requestAd();
      }
    });
  }

  Future<void> _requestAd() async {
    try {
      await TapsellPlus.instance.requestNativeAd(
        StringConstants.nativeAdZoneId,
        onResponse: (response) async {
          setState(() {
            _adId = response['response_id'];
          });
          await _showAd();
        },
        onError: (error) {
          debugPrint('Ad request error: $error');
        },
      );
    } catch (e) {
      debugPrint('Exception during ad request: $e');
    }
  }

  Future<void> _showAd() async {
    if (_adId == null) return;

    await TapsellPlus.instance.showNativeAd(
      _adId!,
      onOpened: (nativeAd) {
        setState(() {
          _adData = (nativeAd as GeneralNativeAdPayload).ad;
        });
      },
      onError: (errorPayload) {
        debugPrint('Error showing ad: $errorPayload');
      },
    );

    await _connectivitySubscription?.cancel();
  }

  @override
  void dispose() async {
    super.dispose();
    await _connectivitySubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    if (_adData != null) {
      switch (widget.size) {
        case TapsellNativeAdSize.standard:
          return NativeStandardBanner(adData: _adData, adId: _adId);
        case TapsellNativeAdSize.large:
          return NativeLargeBanner(adData: _adData, adId: _adId);
        case TapsellNativeAdSize.medium:
          return NativeMediumBanner(adData: _adData, adId: _adId);
      }
    } else {
      return const SizedBox.shrink();
    }
  }
}

class NativeStandardBanner extends StatelessWidget {
  final String? adId;
  final NativeAdData? adData;
  const NativeStandardBanner({
    super.key,
    required this.adId,
    required this.adData,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () async {
          await TapsellPlus.instance.nativeBannerAdClicked(adId!);
        },
        child: Container(
          height: 87,
          width: double.infinity,
          padding: const EdgeInsets.all(4),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black, width: 1),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: adData!.landscapeImageUrl ?? adData!.iconUrl ?? '',
                  height: double.infinity,
                  width: 120,
                  fit: BoxFit.fill,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fadeInDuration: const Duration(milliseconds: 100),
                  memCacheHeight: 200,
                  memCacheWidth: 200,
                ),
              ),
              const Gap(6),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "${adData!.title ?? ''} ${adData!.description ?? ''} ",
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const Gap(4),
                    Container(
                      height: 28,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Color(0xff87562d),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          adData!.callToActionText ?? "",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NativeMediumBanner extends StatelessWidget {
  final String? adId;
  final NativeAdData? adData;
  const NativeMediumBanner({
    super.key,
    required this.adId,
    required this.adData,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () async {
          await TapsellPlus.instance.nativeBannerAdClicked(adId!);
        },
        child: Container(
          height: 104,
          width: double.infinity,
          padding: const EdgeInsets.all(4),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.unselectedWidgetColor, width: 1),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: adData!.landscapeImageUrl ?? adData!.iconUrl ?? '',
                  height: double.infinity,
                  width: 142,
                  fit: BoxFit.fill,
                  fadeInDuration: const Duration(milliseconds: 100),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  memCacheHeight: 200,
                  memCacheWidth: 200,
                ),
              ),
              const Gap(6),
              Expanded(
                child: Column(
                  children: [
                    Expanded(
                      child: Center(
                        child: Text(
                          "${adData!.title ?? ''} ${adData!.description ?? ''} ",
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                    ),
                    const Gap(4),
                    Container(
                      height: 28,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: theme.primaryColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(
                        child: Text(
                          adData!.callToActionText ?? "",
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NativeLargeBanner extends StatelessWidget {
  final String? adId;
  final NativeAdData? adData;
  const NativeLargeBanner({
    super.key,
    required this.adId,
    required this.adData,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: GestureDetector(
        onTap: () async {
          await TapsellPlus.instance.nativeBannerAdClicked(adId!);
        },
        child: Container(
          height: 260,
          width: double.infinity,
          padding: const EdgeInsets.all(4),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: theme.scaffoldBackgroundColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: theme.unselectedWidgetColor, width: 1),
          ),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: adData!.landscapeImageUrl ?? adData!.iconUrl ?? '',
                  height: 148,
                  width: double.infinity,
                  fit: BoxFit.fill,
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                  fadeInDuration: const Duration(milliseconds: 100),
                  memCacheHeight: 200,
                  memCacheWidth: 200,
                ),
              ),
              const Gap(6),
              Expanded(
                child: Center(
                  child: Text(
                    "${adData!.title ?? ''} ${adData!.description ?? ''} ",
                    maxLines: 3,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
              ),
              const Gap(4),
              Container(
                height: 28,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    adData!.callToActionText ?? "",
                    maxLines: 1,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
