import 'package:app/CRUD/controller.dart';
import 'package:app/CRUD/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/list_notifier.dart';

class UserFormScreen extends StatelessWidget {
  // Create TextEditingControllers for the text fields
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  

  final CreateUserController userController = Get.put(CreateUserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Full Name TextField
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Full Name'),
            ),
            const SizedBox(height: 16),
            
            // Email TextField
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            
            // Phone TextField
            TextField(
              controller: phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'Phone No'),
            ),
            const SizedBox(height: 16),
            
            // Password TextField
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(height: 32),
            
            // Submit Button
            ElevatedButton(
              onPressed: () {
                // Call the method to handle user creation
                _createUser();
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  // Step 2: Create a separate method to handle user creation
  void _createUser() {
    final user = UserModel(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      phone: phoneController.text.trim(),
    );
    // Call the controller's createUser method to save the user in Firestore
    userController.createUser(user);
  }
}
