import 'package:dartz/dartz.dart';
import 'package:fal_hafez/data/datasource/fai_hafez_datasource.dart';
import 'package:fal_hafez/model/fai_hafez_model.dart';
import 'package:fal_hafez/networkUtil/api_exception.dart';

abstract class FalHafezRepository {
  Future<Either<String, FalHafezModel>> getFalHafez();
}

class FalHafezRepositoryImpl implements FalHafezRepository {
  final IFalHafezDatasource falHafezDatasource;
  FalHafezRepositoryImpl(this.falHafezDatasource);
  @override
  Future<Either<String, FalHafezModel>> getFalHafez() async {
    try {
      final falHafez = await falHafezDatasource.getFalHafez();
      final FalHafezModel fal = FalHafezModel.fromJson(falHafez);
      return Right(fal);
    } on ApiException catch (e) {
      return Left(e.message ?? 'خطای ناشناخته');
    }
  }
}
