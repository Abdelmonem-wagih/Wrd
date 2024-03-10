// ignore_for_file: public_member_api_docs, sort_constructors_first;
import 'package:dartz/dartz.dart';
import 'package:wrd/core/error/exception.dart';
import 'package:wrd/core/error/failure.dart';
import 'package:wrd/features/islamic_corner/azkar/domain/repository/base_azkar_repository.dart';

import '../../../domain/entities/haju_entities/haju.dart';
import '../../data_source/haju_data_source/haju_romte_data.dart';

class HajuRepository extends BaseHajuRepository {
  final BaseHajuRemoteDataJson baseHajuRemoteData;
  HajuRepository({
    required this.baseHajuRemoteData,
  });

  @override
  Future<Either<Failure, List<Haju>>> getAllHaju() async {
    final resultRemotData = await baseHajuRemoteData.getAllHaju();
    try {
      return Right(resultRemotData);
    }  on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.errorMessageModel.message),
      );
    }
  }
}
