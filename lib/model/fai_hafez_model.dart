import 'package:equatable/equatable.dart';

class FalHafezModel extends Equatable {
  final int status;
  final Result? result;

  const FalHafezModel({required this.status, required this.result});

  factory FalHafezModel.fromJson(Map<String, dynamic> json) {
    return FalHafezModel(
      status: json['status'],
      result: json['result'] != null ? Result.fromJson(json['result']) : null,
    );
  }

  @override
  List<Object?> get props => [status, result];
}

class Result extends Equatable {
  final String? tITLE;
  final String? rHYME;
  final String? mEANING;
  final String? sHOMARE;

  const Result({this.tITLE, this.rHYME, this.mEANING, this.sHOMARE});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      tITLE: json['TITLE'],
      rHYME: json['RHYME'],
      mEANING: json['MEANING'],
      sHOMARE: json['SHOMARE'],
    );
  }

  @override
  List<Object?> get props => [tITLE, rHYME, mEANING, sHOMARE];
}
