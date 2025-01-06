import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:tourist_app/core/error/failure.dart';
import 'package:tourist_app/features/locations/domain/model/location.dart';

abstract interface class LocationRepository {
  Future<Either<Failure, List<Location>>> getAllLocations();
  Future<Either<Failure, Location>> getLocation(Long id);
  List<Location> getFavoriteLocations();
  void setAsFavorite(Location location);
  void removeAsFavorite(Location location);
}
