// ignore_for_file: public_member_api_docs, sort_constructors_first;
import 'package:dartz/dartz.dart';
import 'package:wrd/core/error/exception.dart';
import 'package:wrd/core/error/failure.dart';
import 'package:wrd/features/islamic_corner/azkar/data/data_source/azkar_data_source/azkar_romte_data.dart';
import 'package:wrd/features/islamic_corner/azkar/domain/entities/azkar_entities/azkar.dart';
import 'package:wrd/features/islamic_corner/azkar/domain/repository/base_azkar_repository.dart';

class AzkarRepository extends BaseAzkerRepository {
  final BaseAzkarRemoteDataJson baseAzkarRemoteData;
  AzkarRepository({
    required this.baseAzkarRemoteData,
  });

  @override
  Future<Either<Failure, List<Azkar>>> getAllAzkar() async {
    final resultRemotData = await baseAzkarRemoteData.getAllAzkar();
    try {
      return Right(resultRemotData);
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.errorMessageModel.message),
      );
    }
  }
}
