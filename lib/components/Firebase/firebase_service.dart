// Corrected the path to "widgets"
import 'package:firebase_auth/firebase_auth.dart';

import '../../wigets/tostmessage.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Method to sign up with email and password
  Future<User?> signupWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user; // Return the signed-up user
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase exceptions
      if (e.code == 'email-already-in-use') {
        showToast(message: "The email is already in use.");
      } else {
        showToast(message: "Error: ${e.code}");
      }
      return null; // Return null if there was an error
    }
  }

  // Method to sign in with email and password
  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user; // Return the signed-in user
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase exceptions
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        showToast(message: "Invalid email or password.");
      } else {
        showToast(message: "Error: ${e.code}"); // Display the error message
      }
      return null; // Return null if there was an error
    }
  }

  // Method to sign out the user
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      showToast(message: "Signed out successfully."); // Optional: notify user of successful sign-out
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  // Method to check if the user is currently signed in
  User? getCurrentUser() {
    return _auth.currentUser; // Returns the currently signed-in user or null if no user is signed in
  }
}
