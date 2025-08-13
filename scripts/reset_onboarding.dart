#!/usr/bin/env dart

// Debug script to reset onboarding and clear local storage
// Run with: dart run scripts/reset_onboarding.dart

import 'dart:io';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  print('🔄 Resetting onboarding and clearing local storage...');
  
  try {
    // Initialize Hive
    await Hive.initFlutter();
    
    // Open the user box
    final userBox = await Hive.openBox('user_box');
    
    // Clear all data
    await userBox.clear();
    
    // Close the box
    await userBox.close();
    
    print('✅ Successfully cleared all local storage data!');
    print('📱 Restart the app to go through onboarding again.');
    
  } catch (e) {
    print('❌ Error clearing data: $e');
  }
  
  exit(0);
}
