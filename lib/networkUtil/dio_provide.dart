import 'package:dio/dio.dart';
import 'package:fal_hafez/constans/string_constns.dart';

class DioProvider {
  static Dio createDio() {
    return Dio(BaseOptions(baseUrl: StringConstants.baseUrl));
  }
}
