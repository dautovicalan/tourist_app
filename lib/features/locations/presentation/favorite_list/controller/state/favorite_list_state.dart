import 'package:tourist_app/features/locations/domain/model/location.dart';

sealed class FavoriteListState {}

class FilledState extends FavoriteListState {
  final List<Location> favorites;

  FilledState(this.favorites);
}

class LoadingState extends FavoriteListState {}

class EmptyState extends FavoriteListState {}