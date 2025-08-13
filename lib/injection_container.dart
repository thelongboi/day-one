import 'package:get_it/get_it.dart';

import 'core/storage/local_storage.dart';
import 'features/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'features/onboarding/domain/repositories/onboarding_repository.dart';
import 'features/onboarding/domain/usecases/complete_onboarding.dart';
import 'features/onboarding/domain/usecases/save_user_name.dart';
import 'features/onboarding/presentation/bloc/onboarding_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton<LocalStorage>(() => LocalStorageImpl());

  // Features - Onboarding
  // Bloc
  sl.registerFactory(
    () => OnboardingBloc(saveUserName: sl(), completeOnboarding: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => SaveUserName(sl()));
  sl.registerLazySingleton(() => CompleteOnboarding(sl()));

  // Repository
  sl.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(localDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<OnboardingLocalDataSource>(
    () => OnboardingLocalDataSourceImpl(localStorage: sl()),
  );

  // Initialize local storage
  await sl<LocalStorage>().init();
}
