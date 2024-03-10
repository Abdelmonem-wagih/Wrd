// ignore_for_file: public_member_api_docs, sort_constructors_first;
import 'package:dartz/dartz.dart';
import 'package:wrd/core/error/exception.dart';
import 'package:wrd/core/error/failure.dart';
import 'package:wrd/features/islamic_corner/azkar/domain/entities/tawba_entities/tawba.dart';
import 'package:wrd/features/islamic_corner/azkar/domain/repository/base_azkar_repository.dart';

import '../../data_source/tawba_data_source/tawba_romte_data.dart';

class TawbaRepository extends BaseTawbaRepository {
  final BaseTawbaRemoteDataJson baseTawbaRemoteData;
  TawbaRepository({
    required this.baseTawbaRemoteData,
  });

  @override
  Future<Either<Failure, List<Tawba>>> getAllTawba() async {
    final resultRemotData = await baseTawbaRemoteData.getAllTawba();
    try {
      return Right(resultRemotData);
    }  on  ServerException catch (failure) {
      return Left(
        ServerFailure(failure.errorMessageModel.message),
      );
    }
  }
}
