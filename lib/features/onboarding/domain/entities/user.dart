import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String name;
  final bool onboardingCompleted;

  const User({required this.name, required this.onboardingCompleted});

  @override
  List<Object> get props => [name, onboardingCompleted];
}
