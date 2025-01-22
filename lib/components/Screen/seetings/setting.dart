import 'package:app/components/Screen/authscreen/prifile_screen.dart';
import 'package:app/components/Screen/seetings/notification.dart';
import 'package:app/components/Screen/splash&onboardingScreen/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MoreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFE0EBFB), // Light background color
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage('https://avatars.githubusercontent.com/u/71597653?v=4'), // Replace with your image path
              ),
              SizedBox(height: 10),
              Text(
                'Riaz Ahmed',
                style: TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 5),
              Text(
                '@riazahmed',
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    Get.to(()=>ProfileScreen(userEmail: 'email',));
                    // Add edit profile action here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigate to General Settings page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsScreen()),
                        );
                      },
                      child: _buildListItem(Icons.settings, 'General Settings'),
                    ),
                    _buildListItem(Icons.payment, 'Payments History'),
                    _buildListItem(Icons.question_answer_outlined,
                        'Frequently Asked Question'),
                    _buildListItem(Icons.favorite_outline, 'Favourite Doctors'),
                    _buildListItem(Icons.description_outlined, 'Test Reports'),
                    _buildListItem(Icons.article_outlined, 'Terms & Conditions'),
                    GestureDetector(
                      onTap:  _signOut,
                      child: _buildListItem(Icons.logout, 'Logout')),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build list items
  Widget _buildListItem(IconData icon, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Color(0xFFE8F1FB),
            radius: 25,
            child: Icon(
              icon,
              color: Color(0xFF166CCF),
              size: 28,
            ),
          ),
          SizedBox(width: 16),
          Text(
            title,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}


void _signOut() async {
  await FirebaseAuth.instance.signOut();
  Get.offAll(() => const SplashScreen()); 
}