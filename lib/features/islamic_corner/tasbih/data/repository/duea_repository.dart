// ignore_for_file: public_member_api_docs, sort_constructors_first;
import 'package:dartz/dartz.dart';
import 'package:wrd/core/error/exception.dart';
import 'package:wrd/core/error/failure.dart';
import 'package:wrd/features/islamic_corner/tasbih/domain/entities/tasbih.dart';
import 'package:wrd/features/islamic_corner/tasbih/domain/repository/base_tasbih_repository.dart';

import '../data_source/tasbih_romte_data.dart';

class TasbihRepository extends BaseTasbihRepository {
  final BaseTasbihRemoteDataJson baseTasbihRemoteDataJson;
  TasbihRepository({
    required this.baseTasbihRemoteDataJson,
  });

  @override
  Future<Either<Failure, List<Tasbih>>> getAllTasbih() async {
    final resultRemotData = await baseTasbihRemoteDataJson.getAllTasbih();
    try {
      return Right(resultRemotData);
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.errorMessageModel.message),
      );
    }
  }
}
