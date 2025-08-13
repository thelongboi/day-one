import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../core/storage/local_storage.dart';
import '../../../../injection_container.dart' as di;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _userName = '';

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final localStorage = di.sl<LocalStorage>();
    final name = await localStorage.getUserName();
    if (mounted) {
      setState(() {
        _userName = name ?? 'User';
      });
    }
  }

  Future<void> _resetOnboarding() async {
    final localStorage = di.sl<LocalStorage>();
    await localStorage.setOnboardingCompleted(false);
    // Optionally clear the user name as well
    // await localStorage.saveUserName('');
    
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/onboarding');
    }
  }

  Future<void> _clearAllData() async {
    final localStorage = di.sl<LocalStorage>();
    await localStorage.clearAllData();
    
    if (mounted) {
      Navigator.of(context).pushReplacementNamed('/onboarding');
    }
  }

  void _showDebugOptions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Debug Options'),
          content: const Text(
            'Choose a debug action:',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _resetOnboarding();
              },
              child: const Text('Reset Onboarding Only'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _clearAllData();
              },
              child: const Text('Clear All Data'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Day One'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          // Debug button to reset onboarding (only in debug mode)
          if (kDebugMode)
            IconButton(
              onPressed: _showDebugOptions,
              icon: const Icon(Icons.refresh),
              tooltip: 'Debug Options',
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome message
            Text(
              'Welcome back, $_userName! 👋',
              style: Theme.of(
                context,
              ).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Ready to build some habits today?',
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: Colors.grey[600]),
            ),
            const SizedBox(height: 32),
            // Habits section placeholder
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.track_changes,
                      size: 64,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No habits yet',
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(color: Colors.grey[600]),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Start building your first habit!',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Add habit functionality
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add habit feature coming soon!')),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
