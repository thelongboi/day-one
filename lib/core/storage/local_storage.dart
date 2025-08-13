import 'package:hive_flutter/hive_flutter.dart';

abstract class LocalStorage {
  Future<void> init();
  Future<void> saveUserName(String name);
  Future<String?> getUserName();
  Future<void> setOnboardingCompleted(bool completed);
  Future<bool> isOnboardingCompleted();
  Future<void> clearAllData(); // For debugging purposes
}

class LocalStorageImpl implements LocalStorage {
  static const String _userBoxName = 'user_box';
  static const String _userNameKey = 'user_name';
  static const String _onboardingCompletedKey = 'onboarding_completed';

  late Box _userBox;

  @override
  Future<void> init() async {
    await Hive.initFlutter();
    _userBox = await Hive.openBox(_userBoxName);
  }

  @override
  Future<void> saveUserName(String name) async {
    await _userBox.put(_userNameKey, name);
  }

  @override
  Future<String?> getUserName() async {
    return _userBox.get(_userNameKey);
  }

  @override
  Future<void> setOnboardingCompleted(bool completed) async {
    await _userBox.put(_onboardingCompletedKey, completed);
  }

  @override
  Future<bool> isOnboardingCompleted() async {
    return _userBox.get(_onboardingCompletedKey, defaultValue: false);
  }

  @override
  Future<void> clearAllData() async {
    await _userBox.clear();
  }
}
