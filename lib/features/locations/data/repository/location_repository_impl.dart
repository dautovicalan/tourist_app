import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:tourist_app/core/error/failure.dart';
import 'package:tourist_app/features/locations/data/api/location_api.dart';
import 'package:tourist_app/features/locations/domain/repository/location_repository.dart';

import '../../domain/model/location.dart';
import '../database/database_manager.dart';

class LocationRepositoryImpl implements LocationRepository {
  final LocationApi _locationApi;
  final DatabaseManager _databaseManager;

  const LocationRepositoryImpl(this._locationApi, this._databaseManager);

  @override
  Future<Either<Failure, List<Location>>> getAllLocations() async {
    try {
      final result = await _locationApi.getAllLocations();
      return Right(result);
    } catch (e) {
      return Left(NetworkFailure("There was a network issue."));
    }
  }

  @override
  Future<Either<Failure, Location>> getLocation(Long id) async {
    try {
      final result = await _locationApi.getLocation(id);
      return Right(result);
    } catch (e) {
      return Left(NetworkFailure("There was a network issue."));
    }
  }

  @override
  List<Location> getFavoriteLocations() => _databaseManager.getAllLocations();

  @override
  void removeAsFavorite(final Location location) => _databaseManager.removeAsFavorite(location);

  @override
  void setAsFavorite(final Location location) => _databaseManager.setAsFavorite(location);
}