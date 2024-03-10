// ignore_for_file: public_member_api_docs, sort_constructors_first;
import 'package:dartz/dartz.dart';
import 'package:wrd/core/error/exception.dart';
import 'package:wrd/core/error/failure.dart';
import 'package:wrd/features/islamic_corner/aliadieia/data/data_source/duea_romte_data.dart';
import 'package:wrd/features/islamic_corner/aliadieia/domain/entities/duea.dart';
import 'package:wrd/features/islamic_corner/aliadieia/domain/repository/base_duea_repository.dart';

class DueaRepository extends BaseDueaRepository {
  final BaseDueaRemoteDataJson baseDueaRemoteDataJson;
  DueaRepository({
    required this.baseDueaRemoteDataJson,
  });

  @override
  Future<Either<Failure, List<Duea>>> getAllAliadieia() async {
    final resultRemotData = await baseDueaRemoteDataJson.getAllAliadieia();
    try {
      return Right(resultRemotData);
    } on ServerException catch (failure) {
      return Left(ServerFailure(failure.errorMessageModel.message));
    }
  }
}
