import 'package:doc/services/authentication_service.dart';
import 'package:doc/services/dialog_service.dart';
import 'package:doc/services/navigationService.dart';
import 'package:doc/views/admin/view_models/admin_home_view_model.dart';
import 'package:doc/views/patient/view_models/patient_home_view_model.dart';
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => PatientHomeViewModel());
  locator.registerLazySingleton(() => AdminHomeViewModel());

  // locator.registerLazySingleton(() => DynamicLinkService());
// getIt.registerLazySingleton<Authentication>(() =>Authentication());
// getIt.registerLazySingleton<Authentication>(() =>Authentication());
//! Factory
  // locator.registerFactory(() => VideoAllViewModel());
  // locator.registerFactory(() => VideoPlayerViewViewModel());
  // locator.registerFactory(() => VideoWatchLaterViewModel());
  // locator.registerFactory(() => NewestItemsViewModel());
}
