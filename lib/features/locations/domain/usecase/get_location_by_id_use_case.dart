

import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:tourist_app/features/locations/domain/repository/location_repository.dart';

import '../../../../core/error/failure.dart';
import '../model/location.dart';

class GetLocationByIdUseCase {
  final LocationRepository _repository;

  const GetLocationByIdUseCase(this._repository);

  Future<Either<Failure, Location>> call(Long id) => _repository.getLocation(id);
}