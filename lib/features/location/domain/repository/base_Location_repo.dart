
import 'package:dartz/dartz.dart';
import 'package:wrd/core/error/failure.dart';
import 'package:wrd/features/location/domain/entities/location.dart';


abstract  class  BaseLocationRepository{
  Future<Either<Failure,List<Location>>> getLocation(double latitude, double longitude);
}