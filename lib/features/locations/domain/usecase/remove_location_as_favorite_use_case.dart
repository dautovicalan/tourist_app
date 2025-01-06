import 'package:tourist_app/features/locations/domain/model/location.dart';
import 'package:tourist_app/features/locations/domain/repository/location_repository.dart';

class RemoveAsFavoriteUseCase {
  final LocationRepository _repository;

  const RemoveAsFavoriteUseCase(this._repository);

  void call(final Location location) => _repository.removeAsFavorite(location);
}