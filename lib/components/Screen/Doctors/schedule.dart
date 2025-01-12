import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DoctorScheduleScreen extends StatefulWidget {
  @override
  _DoctorScheduleScreenState createState() => _DoctorScheduleScreenState();
}

class _DoctorScheduleScreenState extends State<DoctorScheduleScreen> {
  DateTime _selectedDate = DateTime.now();
  late List<DateTime> _datesToShow;  // List of dates to show in the horizontal calendar

  @override
  void initState() {
    super.initState();
    _datesToShow = _getNext7Days(DateTime.now());  // Initialize with current week
    _startAutoUpdate(); // Start the automatic update every day
  }

  // Function to generate the next 7 days starting from a given date
  List<DateTime> _getNext7Days(DateTime startDate) {
    return List.generate(7, (index) => startDate.add(Duration(days: index)));
  }

  // Function to get the full month name
  String _getMonthName(DateTime date) {
    return DateFormat('MMMM').format(date);
  }

  // Function to format the day in "dd" format
  String _formatDate(DateTime date) {
    return DateFormat('dd').format(date);
  }

  // Function to get the weekday name for a given date
  String _getWeekday(DateTime date) {
    return DateFormat('EEE').format(date); // Weekday abbreviation (e.g., Mon, Tue)
  }

  // Function to automatically update the date range every day or after every 24 hours
  void _startAutoUpdate() {
    Future.delayed(Duration.zero, () {
      Future.doWhile(() async {
        await Future.delayed(Duration(hours: 24)); // Update once every 24 hours
        DateTime currentDate = DateTime.now();
        if (currentDate.day > _datesToShow[0].day) {
          setState(() {
            _selectedDate = currentDate; // Always select the new day
            _datesToShow = _getNext7Days(currentDate); // Update the 7-day range
          });
        }
        return Future.value(true);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Doctor Time Schedule'),
      ),
      body: Column(
        children: [
          // Horizontal list of days (boxes)
          Container(
            height: 95, // Adjust the height for better visibility
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 7, // Show 7 days
              itemBuilder: (context, index) {
                DateTime day = _datesToShow[index];
                bool isSelected = _selectedDate.isSameDay(day); // Check if the day is selected
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDate = day;
                    });
                  },

                  child: Container(
                    width: 72,
                    margin: EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      gradient: isSelected
                          ? LinearGradient( // Apply gradient if selected
                        colors: [
                          Color.fromARGB(255, 66, 165, 245), // Light blue
                          Color.fromARGB(255, 41, 121, 255)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                          : LinearGradient( // Apply a different gradient if not selected
                        colors: [
                          Color.fromARGB(255, 200, 230, 255), // Lighter shade
                          Color.fromARGB(255, 255, 255, 255)
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Display the month at the top of the box
                        Text(
                          _getMonthName(day),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.white : Colors.grey.shade600,
                          ),
                        ),
                        // Display the day (Mon, Tue, etc.) at the top
                        Text(
                          _getWeekday(day),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: isSelected ? Colors.white : Colors.grey.shade600,
                          ),
                        ),
                        // Display the date (12, 13, etc.) at the bottom
                        Text(
                          _formatDate(day),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                            color: isSelected ? Colors.white : Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Text("data"),

        ],
      ),
    );
  }
}

extension DateComparison on DateTime {
  bool isSameDay(DateTime other) {
    return this.year == other.year && this.month == other.month && this.day == other.day;
  }
}
