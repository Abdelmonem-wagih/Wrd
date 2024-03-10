// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:wrd/core/error/failure.dart';
import 'package:wrd/core/usecases/usecase.dart';
import 'package:wrd/features/location/domain/entities/location.dart';
import 'package:wrd/features/location/domain/repository/base_Location_repo.dart';

class LocationUseCase extends UseCase<List<Location>, LocationUseCaseParams> {
  final BaseLocationRepository baseLocationRepository;
  LocationUseCase({
    required this.baseLocationRepository,
  });
  @override
  Future<Either<Failure, List<Location>>> call(
      LocationUseCaseParams params) async {
    return await baseLocationRepository.getLocation(
        params.latitude, params.longitude);
  }
}
