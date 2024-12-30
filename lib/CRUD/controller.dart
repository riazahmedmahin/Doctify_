import 'package:app/CRUD/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CreateUserController extends GetxController {
  
  static CreateUserController get instance => Get.find();

  final _db = FirebaseFirestore.instance;

  // Method to create a new user in Firestore
  Future<void> createUser(UserModel user) async {
    try {
      // Add user data to Firestore
      await _db.collection('users').add(user.toJson());

      // Show success message
      Get.snackbar('Success', 'User added successfully!');
    } catch (e) {
      // Show error message if the addition fails
      Get.snackbar('Error', 'Failed to add user: $e');
    }
  }
}
