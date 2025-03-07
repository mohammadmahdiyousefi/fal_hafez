import 'package:fal_hafez/di/di.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppRate {
  static const String _commenting = 'commenting';
  static const String _commentCount = 'commentingcount';
  static const int _count = 3;
  static bool _isRate = false;
  static final SharedPreferences _prefs = locator.get<SharedPreferences>();

  static Future<void> init() async {
    try {
      _isRate = await _hasUserGivenRate();
      if (!_isRate) {
        await _increaseCommentingcount();
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> _hasUserGivenRate() async {
    try {
      return _prefs.getBool(_commenting) ?? false;
    } catch (e) {
      return false;
    }
  }

  static Future<void> setRateGiven() async {
    if (_isRate) return;
    try {
      await _prefs.setBool(_commenting, true);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  static Future<void> _increaseCommentingcount() async {
    try {
      final int count = (_prefs.getInt(_commentCount) ?? 0) + 1;
      await _prefs.setInt(_commentCount, count);
    } catch (e) {
      rethrow;
    }
  }

  static Future<int> _getCommentingcount() async {
    try {
      return _prefs.getInt(_commentCount) ?? 0;
    } catch (e) {
      return 0;
    }
  }

  static Future<void> _resetCommentingcount() async {
    try {
      final int count = _prefs.getInt(_commentCount) ?? 0;
      if (count > _count) {
        await _prefs.remove(_commentCount);
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> showRateDialog() async {
    if (_isRate) return false;
    try {
      final int count = await _getCommentingcount();
      if (count > _count) {
        await _resetCommentingcount();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
