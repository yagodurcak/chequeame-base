import 'package:chequeamefirestore2/services/api.dart';
import 'package:chequeamefirestore2/services/authentication_service.dart';
import 'package:chequeamefirestore2/services/dialog_service.dart';
import 'package:chequeamefirestore2/services/firestore_service.dart';
import 'package:chequeamefirestore2/services/info_service.dart';
import 'package:chequeamefirestore2/services/navigation_service.dart';
import 'package:chequeamefirestore2/ui/views/post_view.dart';
import 'package:chequeamefirestore2/viewmodels/home_model.dart';

import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => PostView());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => FirestoreService());
  locator.registerLazySingleton(() => InfoService());
  locator.registerLazySingleton(() => Api());

  locator.registerFactory(() => HomeModel());
}
