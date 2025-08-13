import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/usecases/complete_onboarding.dart';
import '../../domain/usecases/save_user_name.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final SaveUserName saveUserName;
  final CompleteOnboarding completeOnboarding;

  OnboardingBloc({required this.saveUserName, required this.completeOnboarding})
    : super(const OnboardingInitial()) {
    on<SaveUserNameEvent>(_onSaveUserName);
    on<CompleteOnboardingEvent>(_onCompleteOnboarding);
  }

  Future<void> _onSaveUserName(
    SaveUserNameEvent event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(const OnboardingSaving());

    final result = await saveUserName(SaveUserNameParams(name: event.name));

    result.fold(
      (failure) => emit(OnboardingError(failure.message)),
      (_) => emit(const OnboardingUserNameSaved()),
    );
  }

  Future<void> _onCompleteOnboarding(
    CompleteOnboardingEvent event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(const OnboardingLoading());

    final result = await completeOnboarding(NoParams());

    result.fold(
      (failure) => emit(OnboardingError(failure.message)),
      (_) => emit(const OnboardingCompleted()),
    );
  }
}
