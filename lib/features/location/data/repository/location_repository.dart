// ignore_for_file: public_member_api_docs, sort_constructors_first;
import 'package:dartz/dartz.dart';
import 'package:wrd/core/error/exception.dart';
import 'package:wrd/core/error/failure.dart';
import 'package:wrd/features/location/domain/entities/location.dart';
import '../../domain/repository/base_Location_repo.dart';
import '../data_source/loaction_remote_data_source.dart';

class LocationRepository extends BaseLocationRepository {
  final BaseLocationRemoteData locationRemoteDataDio;
  LocationRepository({
    required this.locationRemoteDataDio,
  });

  @override
  Future<Either<Failure, List<Location>>> getLocation(double latitude, double longitude) async {
    try {
      final resultRemotData = await locationRemoteDataDio.getLocation(latitude,longitude);
      return Right(resultRemotData);
    } on ServerException catch (failure) {
      return Left(
        ServerFailure(failure.errorMessageModel.message),
      );
    }

  }
}
