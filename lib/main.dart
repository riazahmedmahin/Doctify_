import 'package:app/components/Screen/authscreen/auth.dart';
import 'package:app/components/Screen/splash&onboardingScreen/splash_screen.dart';
import 'package:app/firebase_options.dart';
import 'package:app/components/Screen/payment/keys.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  // Set Stripe publishable key
  Stripe.publishableKey = publishableKey; // From keys.dart
  await Stripe.instance.applySettings();  // Apply Stripe settings

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MedicalApp());
}

class MedicalApp extends StatelessWidget {
  const MedicalApp({super.key});
  @override
  Widget build(BuildContext context) {

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthHandler(),
    );
  }
}