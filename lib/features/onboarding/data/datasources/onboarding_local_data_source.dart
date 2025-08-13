import '../../../../core/storage/local_storage.dart';

abstract class OnboardingLocalDataSource {
  Future<void> saveUserName(String name);
  Future<String?> getUserName();
  Future<void> completeOnboarding();
  Future<bool> isOnboardingCompleted();
}

class OnboardingLocalDataSourceImpl implements OnboardingLocalDataSource {
  final LocalStorage localStorage;

  OnboardingLocalDataSourceImpl({required this.localStorage});

  @override
  Future<void> saveUserName(String name) async {
    await localStorage.saveUserName(name);
  }

  @override
  Future<String?> getUserName() async {
    return await localStorage.getUserName();
  }

  @override
  Future<void> completeOnboarding() async {
    await localStorage.setOnboardingCompleted(true);
  }

  @override
  Future<bool> isOnboardingCompleted() async {
    return await localStorage.isOnboardingCompleted();
  }
}
