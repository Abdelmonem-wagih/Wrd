// ignore_for_file: public_member_api_docs, sort_constructors_first;
import 'package:dartz/dartz.dart';
import 'package:wrd/core/error/exception.dart';
import 'package:wrd/core/error/failure.dart';
import 'package:wrd/features/islamic_corner/azkar/data/data_source/tashahhud_data_source/tashahhud_romte_data.dart';
import 'package:wrd/features/islamic_corner/azkar/domain/entities/tashahhud_entities/tashahhud.dart';
import 'package:wrd/features/islamic_corner/azkar/domain/repository/base_azkar_repository.dart';

class TashahhudRepository extends BaseTashahhudRepository {
  final BaseTashahhudRemoteDataJson baseTashahhudRemoteData;
  TashahhudRepository({
    required this.baseTashahhudRemoteData,
  });

  @override
  Future<Either<Failure, List<Tashahhud>>> getAllTashahhud() async {
    final resultRemotData = await baseTashahhudRemoteData.getAllTashahhud();
    try {
      return Right(resultRemotData);
    }  on  ServerException catch (failure) {
      return Left(
        ServerFailure(failure.errorMessageModel.message),
      );
    }
  }
}
