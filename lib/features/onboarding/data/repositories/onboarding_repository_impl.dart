import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/repositories/onboarding_repository.dart';
import '../datasources/onboarding_local_data_source.dart';

class OnboardingRepositoryImpl implements OnboardingRepository {
  final OnboardingLocalDataSource localDataSource;

  OnboardingRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, void>> saveUserName(String name) async {
    try {
      await localDataSource.saveUserName(name);
      return const Right(null);
    } catch (e) {
      return Left(StorageFailure('Failed to save user name: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, String?>> getUserName() async {
    try {
      final name = await localDataSource.getUserName();
      return Right(name);
    } catch (e) {
      return Left(StorageFailure('Failed to get user name: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> completeOnboarding() async {
    try {
      await localDataSource.completeOnboarding();
      return const Right(null);
    } catch (e) {
      return Left(
        StorageFailure('Failed to complete onboarding: ${e.toString()}'),
      );
    }
  }

  @override
  Future<Either<Failure, bool>> isOnboardingCompleted() async {
    try {
      final isCompleted = await localDataSource.isOnboardingCompleted();
      return Right(isCompleted);
    } catch (e) {
      return Left(
        StorageFailure('Failed to check onboarding status: ${e.toString()}'),
      );
    }
  }
}
