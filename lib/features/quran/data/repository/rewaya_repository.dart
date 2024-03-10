// ignore_for_file: public_member_api_docs, sort_constructors_first;
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:wrd/core/error/exception.dart';
import 'package:wrd/core/error/failure.dart';
import 'package:wrd/features/quran/data/data_source/rewayat_remote_data.dart';

import '../../domain/repository/base_rewaya_repository.dart';
import '../model/quranAudio/rewaya_model.dart';

class RewayatRepository extends BaseRewayaRepository {
  final BaseRewayatRemoteData baseRewayatRemoteData;
  RewayatRepository({
    required this.baseRewayatRemoteData,
  });

  @override
  Future<Either<Failure, List<RewayaModel>>> getRewayat() async {
    final resultRemotData = await baseRewayatRemoteData.geRewayat();
    try {
      debugPrint('Right(resultRemotData)${Right(resultRemotData)}');
      return Right(resultRemotData);
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.errorMessageModel.message),
      );
    }
  }
}
