import 'package:tourist_app/features/locations/domain/model/location.dart';
import 'package:tourist_app/features/locations/domain/repository/location_repository.dart';

class SetLocationAsFavoriteUseCase {
  final LocationRepository _repository;

  const SetLocationAsFavoriteUseCase(this._repository);

  void call(final Location location) =>
    _repository.getFavoriteLocations().contains(location)
        ? _repository.removeAsFavorite(location)
        : _repository.setAsFavorite(location);
}