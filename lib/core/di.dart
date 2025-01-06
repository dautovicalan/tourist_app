import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tourist_app/features/auth/data/api/user_api.dart';
import 'package:tourist_app/features/auth/data/repository/user_repository_impl.dart';
import 'package:tourist_app/features/auth/domain/repository/user_repository.dart';
import 'package:tourist_app/features/auth/domain/usecase/get_current_user_use_case.dart';
import 'package:tourist_app/features/auth/domain/usecase/send_verify_email_use_case.dart';
import 'package:tourist_app/features/auth/domain/usecase/sign_in_use_case.dart';
import 'package:tourist_app/features/auth/presentation/controller/auth_controller.dart';
import 'package:tourist_app/features/auth/presentation/controller/state/auth_state.dart';
import 'package:tourist_app/features/locations/data/api/location_api.dart';
import 'package:tourist_app/features/locations/data/repository/location_repository_impl.dart';
import 'package:tourist_app/features/locations/domain/repository/location_repository.dart';
import 'package:tourist_app/features/locations/domain/usecase/get_all_locations_use_case.dart';
import 'package:tourist_app/features/locations/domain/usecase/get_location_by_id_use_case.dart';
import 'package:tourist_app/features/locations/presentation/location_list/controller/location_list_controller.dart';
import 'package:tourist_app/features/locations/presentation/location_list/controller/state/location_list_state.dart';

import '../features/auth/domain/usecase/deactivate_profile_use_case.dart';
import '../features/auth/domain/usecase/reset_password_use_case.dart';
import '../features/auth/domain/usecase/sign_out_use_case.dart';
import '../features/auth/domain/usecase/sign_up_use_case.dart';
import '../features/locations/data/database/database_manager.dart';
import '../features/locations/data/database/hive_manager.dart';
import '../features/locations/domain/usecase/get_favorite_locations_use_case.dart';
import '../features/locations/domain/usecase/remove_location_as_favorite_use_case.dart';
import '../features/locations/domain/usecase/set_location_as_favorite_use_case.dart';
import '../features/locations/presentation/favorite_list/controller/favorite_list_controller.dart';
import '../features/locations/presentation/favorite_list/controller/state/favorite_list_state.dart';

//******** API ********//
final userApiProvider = Provider<UserApi>((ref) => UserApi(FirebaseAuth.instance));

final locationApiProvider = Provider<LocationApi>((ref) => LocationApi(Dio()));

//******** DATABASE ********//
final databaseMangerProvider = Provider<DatabaseManager>((ref) => HiveDatabaseManager());

//******** REPOSITORY ********//
final userRepositoryProvider = Provider<UserRepository>((ref) => UserRepositoryImpl(ref.watch(userApiProvider)));

final locationRepositoryProvider = Provider<LocationRepository>((ref) => LocationRepositoryImpl(
    ref.watch(locationApiProvider),
    ref.watch(databaseMangerProvider),
  ),
);

//******** USE CASE ********//
final getCurrentUserUseCaseProvider = Provider<GetCurrentUserUseCase>((ref) => GetCurrentUserUseCase(ref.watch(userRepositoryProvider)));
final signInUseCaseProvider = Provider<SignInUseCase>((ref) => SignInUseCase(ref.watch(userRepositoryProvider)));
final signUpUseCaseProvider = Provider<SignUpUseCase>((ref) => SignUpUseCase(ref.watch(userRepositoryProvider)));
final signOutUseCaseProvider = Provider<SignOutUseCase>((ref) => SignOutUseCase(ref.watch(userRepositoryProvider)));
final resetPasswordUseCaseProvider = Provider<ResetPasswordUseCase>((ref) => ResetPasswordUseCase(ref.watch(userRepositoryProvider)));
final sendVerifyEmailUseCaseProvider = Provider<SendVerifyEmailUseCase>((ref) => SendVerifyEmailUseCase(ref.watch(userRepositoryProvider)));
final deactivateProfileUseCaseProvider = Provider<DeactivateProfileUseCase>((ref) => DeactivateProfileUseCase(ref.watch(userRepositoryProvider)));

final getAllLocationsUseCaseProvider = Provider<GetAllLocationsUseCase>(
  (ref) => GetAllLocationsUseCase(ref.watch(locationRepositoryProvider)),
);

final getAllFavoriteLocationsUseCaseProvider = Provider<GetAllFavoriteLocationsUseCase>(
      (ref) => GetAllFavoriteLocationsUseCase(ref.watch(locationRepositoryProvider)),
);

final setAsFavoriteUseCaseProvider = Provider<SetLocationAsFavoriteUseCase>(
      (ref) => SetLocationAsFavoriteUseCase(ref.watch(locationRepositoryProvider)),
);

final removeAsFavoriteUseCaseProvider = Provider<RemoveAsFavoriteUseCase>(
      (ref) => RemoveAsFavoriteUseCase(ref.watch(locationRepositoryProvider)),
);

final getLocationUseCaseProvider = Provider<GetLocationByIdUseCase>(
  (ref) => GetLocationByIdUseCase(ref.watch(locationRepositoryProvider)),
);

final getAllFavoriteUseCaseProvider = Provider<GetAllFavoriteLocationsUseCase>(
  (ref) => GetAllFavoriteLocationsUseCase(ref.watch(locationRepositoryProvider)),
);

//******** NOTIFIER ********//
final authNotifier = NotifierProvider<AuthController, AuthState>(() => AuthController());

final locationListNotifier = NotifierProvider<LocationListController, LocationListState>(
  () => LocationListController(),
);

final favoriteListNotifier = NotifierProvider<FavoriteListController, FavoriteListState>(
      () => FavoriteListController(),
);
