import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class OnboardingRepository {
  Future<Either<Failure, void>> saveUserName(String name);
  Future<Either<Failure, String?>> getUserName();
  Future<Either<Failure, void>> completeOnboarding();
  Future<Either<Failure, bool>> isOnboardingCompleted();
}
