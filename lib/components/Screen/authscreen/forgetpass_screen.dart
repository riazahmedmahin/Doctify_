import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance; // Firebase Auth instance
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(),
              borderRadius: BorderRadius.circular(12),
            ),
            child: InkWell(
              onTap: () => Navigator.pop(context),
              child: Icon(
                Icons.arrow_back,
                size: 20,
              ),
            ),
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
        child: Column(
          children: [
            const SizedBox(height: 20),
            ClipOval(
              child: Image.network(
                "https://cdn-icons-png.flaticon.com/128/17969/17969464.png",
                fit: BoxFit.fill,
                height: 130,
                width: 130,
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Please Enter Your Email to Receive a Verification Code",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 50),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _isLoading ? null : _sendPasswordResetEmail,
              child: _isLoading
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text(
                      'Send',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 22, 108, 207),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 164, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.circular(12), // Border radius set to 12
                  )),
            ),
          ],
        ),
      ),
    );
  }

  void _sendPasswordResetEmail() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      Get.snackbar("Error", "Please enter your email",
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.snackbar(
        "Success",
        "Password reset email sent. Check your inbox.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        "Error",
        e.message ?? "An error occurred",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "An unexpected error occurred.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
