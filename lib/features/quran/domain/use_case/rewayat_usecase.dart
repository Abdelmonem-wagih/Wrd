// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:wrd/core/error/failure.dart';
import 'package:wrd/core/usecases/usecase.dart';

import '../entities/quranAudio/rewaya.dart';
import '../repository/base_rewaya_repository.dart';

class RewayaUseCase extends UseCase<List<Rewaya>, NoParams> {
  final BaseRewayaRepository baseRewayaRepository;
  RewayaUseCase({
    required this.baseRewayaRepository,
  });
  @override
  Future<Either<Failure, List<Rewaya>>> call(
    NoParams params, {
    int? rewaya,
  }) async {
    return await baseRewayaRepository.getRewayat();
  }
}
