// ignore_for_file: public_member_api_docs, sort_constructors_first;
import 'package:dartz/dartz.dart';
import 'package:wrd/core/error/exception.dart';
import 'package:wrd/core/error/failure.dart';
import 'package:wrd/features/islamic_corner/azkar/domain/entities/zkar_entities/zkar.dart';
import 'package:wrd/features/islamic_corner/azkar/domain/repository/base_azkar_repository.dart';

import '../../data_source/zkar_data_source/zkar_romte_data.dart';

class ZkarRepository extends BaseZkerRepository {
  final BaseZkarRemoteDataJson baseZkarRemoteData;
  ZkarRepository({
    required this.baseZkarRemoteData,
  });

  @override
  Future<Either<Failure, List<Zkar>>> getAllZkar() async {
    final resultRemotData = await baseZkarRemoteData.getAllZkar();
    try {
      return Right(resultRemotData);
    }  on  ServerException catch (failure) {
      return Left(
        ServerFailure(failure.errorMessageModel.message),
      );
    }
  }
}
