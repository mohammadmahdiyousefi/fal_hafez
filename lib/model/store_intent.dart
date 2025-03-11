class StoreIntent {
  const StoreIntent._();
  // cafe bazaar intents and url
  static const String _bazaaruUrl = "https://cafebazaar.ir/app/";
  static const String _bazzarPakage = "com.farsitel.bazaar";
  static const String _bazzarAction = "android.intent.action.EDIT";
  static const String _bazzarData = "bazaar://details?id=com.app.fal_hafez";
  static const String _bazzarDeveloperApp =
      "https://cafebazaar.ir/developer/mmahdi_81_8_2";

  // mayket intents and url
  // static const String _myketUrl = "https://myket.ir/app/";
  // static const String _myketPakage = "ir.mservices.market";
  // static const String _myketAction = "android.intent.action.VIEW";
  // static const String _myketData =
  //     "myket://comment?id=com.app.fal_hafez";
  // static const String _myketDeveloperApp =
  //     "https://myket.ir/developer/dev-82300";

  // store data
  static const String _storeData = _bazzarData;
  static const String _storePakage = _bazzarPakage;
  static const String _storeAction = _bazzarAction;
  static const String _storeUrl = _bazaaruUrl;
  static const String _storeDeveloperApp = _bazzarDeveloperApp;

  // get data
  static String get storeUrl => _storeUrl;
  static String get storeData => _storeData;
  static String get storePakage => _storePakage;
  static String get storeAction => _storeAction;
  static String get falHafezUrl => "${_storeUrl}com.app.fal_hafez";
  static String get storeDeveloperApp => _storeDeveloperApp;
}
