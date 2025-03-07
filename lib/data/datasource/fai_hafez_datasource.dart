import 'package:dio/dio.dart';
import 'package:fal_hafez/constans/string_constns.dart';
import 'package:fal_hafez/networkUtil/api_exception.dart';

abstract class IFalHafezDatasource {
  Future<dynamic> getFalHafez();
}

class FalHafezDatasource implements IFalHafezDatasource {
  final Dio dio;
  FalHafezDatasource(this.dio);
  @override
  Future<dynamic> getFalHafez() async {
    try {
      final queryParameters = {'token': StringConstants.keyToken};
      final Response<dynamic> response = await dio.get(
        'hafez/',
        queryParameters: queryParameters,
      );
      if (response.statusCode == 200) {
        if (response.data['status'] != 200) {
          throw ApiException(response.data['status'], response.data['message']);
        }
        return response.data;
      } else {
        throw ApiException(response.statusCode, response.statusMessage);
      }
    } on DioException catch (e) {
      throw ApiException(e.response!.statusCode, e.response!.statusMessage);
    } catch (ex) {
      throw ApiException(0, 'unknown erorr');
    }
  }
}
