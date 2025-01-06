import 'package:tourist_app/core/error/failure.dart';
import 'package:tourist_app/features/locations/domain/model/location.dart';

sealed class LocationDetailState {}

class LoadingState extends LocationDetailState {}

class FilledState extends LocationDetailState {
  final Location location;

  FilledState(this.location);
}

class EmptyState extends LocationDetailState {}

class ErrorState extends LocationDetailState {
  final Failure failure;

  ErrorState(this.failure);
}