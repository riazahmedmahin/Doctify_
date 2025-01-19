import 'package:app/components/Screen/MainBottomNavScreen.dart';
import 'package:app/components/Screen/splash&onboardingScreen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class AuthHandler extends StatelessWidget {
  const AuthHandler({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // If the user is signed in, navigate to the main screen
        if (snapshot.hasData) {
          return MainBottomNavScreen();
        }

        // Otherwise, show the splash screen (or sign-in screen)
        return const SplashScreen();
      },
    );
  }
}
