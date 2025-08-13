import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/onboarding_bloc.dart';
import '../widgets/name_input_widget.dart';
import '../widgets/onboarding_content.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _onNameSubmitted(String name) {
    context.read<OnboardingBloc>().add(SaveUserNameEvent(name));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<OnboardingBloc, OnboardingState>(
          listener: (context, state) {
            if (state is OnboardingUserNameSaved) {
              // Complete onboarding and navigate to home
              context.read<OnboardingBloc>().add(
                const CompleteOnboardingEvent(),
              );
            } else if (state is OnboardingCompleted) {
              // Navigate to home screen
              Navigator.of(context).pushReplacementNamed('/home');
            } else if (state is OnboardingError) {
              // Show error message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Column(
            children: [
              // Progress indicator
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: List.generate(
                    3,
                    (index) => Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 4,
                        decoration: BoxDecoration(
                          color: index <= _currentPage
                              ? Colors.blue
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // Page content
              Expanded(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: [
                    // Page 1
                    OnboardingContent(
                      title: 'Track Your Habits',
                      description:
                          'Build better habits and track your progress with our simple and intuitive habit tracker. Start your journey to a better you today.',
                      image: const PlaceholderImage(color: Colors.blue),
                    ),
                    // Page 2
                    OnboardingContent(
                      title: 'Stay Motivated',
                      description:
                          'Set daily goals, track your streaks, and celebrate your achievements. Our app will keep you motivated on your habit-building journey.',
                      image: const PlaceholderImage(color: Colors.green),
                    ),
                    // Page 3 - Name input
                    BlocBuilder<OnboardingBloc, OnboardingState>(
                      builder: (context, state) {
                        return NameInputWidget(
                          onNameSubmitted: _onNameSubmitted,
                          isLoading:
                              state is OnboardingSaving ||
                              state is OnboardingLoading,
                        );
                      },
                    ),
                  ],
                ),
              ),
              // Navigation buttons
              if (_currentPage < 2)
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Skip button
                      TextButton(
                        onPressed: () {
                          _pageController.animateToPage(
                            2,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        },
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 16,
                          ),
                        ),
                      ),
                      // Next button
                      ElevatedButton(
                        onPressed: _nextPage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 12,
                          ),
                        ),
                        child: const Text(
                          'Next',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
