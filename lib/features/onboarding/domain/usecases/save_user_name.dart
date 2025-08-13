import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/onboarding_repository.dart';

class SaveUserName implements UseCase<void, SaveUserNameParams> {
  final OnboardingRepository repository;

  SaveUserName(this.repository);

  @override
  Future<Either<Failure, void>> call(SaveUserNameParams params) async {
    return await repository.saveUserName(params.name);
  }
}

class SaveUserNameParams {
  final String name;

  SaveUserNameParams({required this.name});
}
