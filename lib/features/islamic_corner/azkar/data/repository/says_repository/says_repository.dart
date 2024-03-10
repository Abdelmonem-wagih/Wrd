// ignore_for_file: public_member_api_docs, sort_constructors_first;
import 'package:dartz/dartz.dart';
import 'package:wrd/core/error/exception.dart';
import 'package:wrd/core/error/failure.dart';
import 'package:wrd/features/islamic_corner/azkar/domain/entities/says_entities/says.dart';
import 'package:wrd/features/islamic_corner/azkar/domain/repository/base_azkar_repository.dart';

import '../../data_source/says_data_source/says_romte_data.dart';

class SaysRepository extends BaseSaysRepository {
  final BaseSaysRemoteDataJson baseSaysRemoteData;
  SaysRepository({
    required this.baseSaysRemoteData,
  });

  @override
  Future<Either<Failure, List<Says>>> getAllSays() async {
    final resultRemotData = await baseSaysRemoteData.getAllSays();
    try {
      return Right(resultRemotData);
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.errorMessageModel.message),
      );
    }
  }
}
