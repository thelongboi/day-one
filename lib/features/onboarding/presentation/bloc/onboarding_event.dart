part of 'onboarding_bloc.dart';

abstract class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object> get props => [];
}

class SaveUserNameEvent extends OnboardingEvent {
  final String name;

  const SaveUserNameEvent(this.name);

  @override
  List<Object> get props => [name];
}

class CompleteOnboardingEvent extends OnboardingEvent {
  const CompleteOnboardingEvent();
}
