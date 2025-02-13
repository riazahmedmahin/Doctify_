import 'package:app/components/Screen/Doctor_profile.dart';
import 'package:app/components/Screen/Doctors/Doctor_list_screen.dart';
import 'package:app/components/Screen/home_pages.dart';
import 'package:app/components/Screen/SeetingsScreen/setting.dart';
import 'package:flutter/material.dart';

import 'MessageScreen/inbox.dart';

class MainBottomNavScreen extends StatefulWidget {
  @override
  _MainBottomNavScreenState createState() => _MainBottomNavScreenState();
}

class _MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    HomePages(),
    //DoctorProfileScreen(),
    DoctorListScreen(),
    ChatsScreen(),
    //InboxPage(),
    MoreScreen(),
    //ProfileScreen()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 224, 235, 251),
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16, bottom: 10),
          child: Container(
            height: 75,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 22, 108, 207),
              borderRadius: BorderRadius.circular(17),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 1,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Theme(
                data: Theme.of(context).copyWith(
                  splashColor: Colors.transparent, // Disable splash effect
                  highlightColor: Colors.transparent, // Disable highlight effect
                ),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  selectedItemColor: Colors.blue,
                  unselectedItemColor: Colors.grey,
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                  currentIndex: _selectedIndex,
                  onTap: _onItemTapped,
                  items: [
                    BottomNavigationBarItem(
                      icon: _buildIconWithBackground(Icons.home_filled, 0),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: _buildIconWithBackground(Icons.person_sharp, 1),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: _buildIconWithBackground(Icons.chat_bubble_outline, 2),
                      label: '',
                    ),
                    BottomNavigationBarItem(
                      icon: _buildIconWithBackground(Icons.widgets_outlined, 3),
                      label: '',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIconWithBackground(IconData iconData, int index) {
    bool isSelected = _selectedIndex == index;

    return Container(
      decoration: isSelected
          ? BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        shape: BoxShape.circle,
      )
          : null,
      padding: const EdgeInsets.all(8),
      child: Icon(
        iconData,
        size: 24,
        color: isSelected ? Colors.white : Colors.grey.shade500,
      ),
    );
  }
}
