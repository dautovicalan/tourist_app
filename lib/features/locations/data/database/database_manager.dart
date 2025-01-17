import 'package:tourist_app/features/locations/domain/model/location.dart';

abstract interface class DatabaseManager {
  List<Location> getAllLocations();
  void setAsFavorite(Location location);
  void removeAsFavorite(Location location);
}