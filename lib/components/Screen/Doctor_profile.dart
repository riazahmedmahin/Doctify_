import 'package:flutter/material.dart';

class DoctorProfileScreen extends StatefulWidget {
  @override
  _DoctorProfileScreenState createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  int selectedDay = 0; // Initially selected day
  TimeOfDay? selectedTime; // Time of day selected by user
  String selectedMonth = "August"; // Selected month
  final List<String> days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"];

  final List<String> months = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December"
  ];

  int currentMonthIndex = 7; // Starting index for August
  int currentYear = 2024; // Assuming current year for simplicity

  List<int> getDatesForCurrentMonth() {
    int daysInMonth = DateTime(currentYear, currentMonthIndex + 1, 0).day;
    return List.generate(daysInMonth, (index) => index + 1);
  }

  List<int> getDates() {
    return getDatesForCurrentMonth();
  }

  void changeMonth(int change) {
    setState(() {
      currentMonthIndex += change;

      if (currentMonthIndex < 0) {
        currentMonthIndex = 11; // Go to December
        currentYear--; // Decrement year when going to the previous December
      } else if (currentMonthIndex > 11) {
        currentMonthIndex = 0; // Go to January
        currentYear++; // Increment year when going to the next January
      }
      selectedMonth = months[currentMonthIndex]; // Update selected month
    });
  }

  void toggleDateSelection(int date) {
    setState(() {
      // If the date is already selected, deselect it
      if (selectedDay == date) {
        selectedDay = 0; // Reset selected day
      } else {
        selectedDay = date; // Select the new day
        selectedTime = null; // Reset selected time when a new date is selected
      }
    });
  }

  void _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime ?? TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked; // Update the selected time
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<int> dates = getDates(); // Get the dates for the current month
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 224, 235, 251),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40,),
              // Profile Section
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30.0,
                    backgroundColor: Colors.blueAccent,
                    child: Image.network(
                      "https://cdn-icons-png.flaticon.com/128/2785/2785482.png",
                      height: 50,
                      width: 50,
                      //fit:BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Dr. Aminul Haque",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4.0),
                      Text(
                        "Cardiologist - City hospital",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Text(
                          "4.5",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.star,
                          color: Colors.yellow[700],
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              
              // Stats (Patients, Experience)
              Row(
                children: [
                  Expanded(
                    child: _InfoCard(
                      title: "Patients",
                      value: "100+",
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: _InfoCard(
                      title: "Experience",
                      value: "3yrs+",
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24.0),
              
              // About Section
              Text(
                "About Doctor",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0),
              Text(
                "I completed my MBBS in 2003, D. Card (BSMMU), and Ph.D. 2021 (AIU, California). Consultant cardiologist with a special interest in noninvasive and preventive cardiology. Advanced training in echocardiography (Delhi, India) ",

                style: TextStyle(color: Colors.grey[600]),
              ),
              const SizedBox(height: 24.0),
              
              // Availability Section
              Text(
                "Availability",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5.0),
              
              // Month Display
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedMonth,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  // Change Month Buttons
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () => changeMonth(-1),
                      ),
                      IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () => changeMonth(1),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16.0),
              
              // Days and Dates Row with horizontal scroll
              // Days and Dates Row with horizontal scroll
              SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Enables horizontal scrolling
                child: Row(
                  children: List.generate(dates.length, (index) {
                    bool isSelected = selectedDay ==
                        dates[index]; // Check if the date is selected
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0), // Space between items
                      child: GestureDetector(
                        onTap: () {
                          toggleDateSelection(dates[index]); // Toggle selection
                        },
                        child: Container(
                          width:
                              60, // Adjusted width to accommodate both day and date
                          height:
                              70, // Adjusted height to accommodate both day and date
                          decoration: BoxDecoration(
                            gradient: isSelected
                                ? LinearGradient(
                                    colors: [
                                      Color.fromARGB(
                                          255, 66, 165, 245), // Light blue
                                      Color.fromARGB(
                                          255, 41, 121, 255) // Dark blue
                                    ],
                                  )
                                : LinearGradient(
                                    colors: [
                                      Color.fromARGB(
                                          255, 200, 230, 255), // Lighter shade
                                      Color.fromARGB(255, 255, 255, 255) // White
                                    ],
                                  ),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.transparent,
                              width: 2,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Day Text
                              Text(
                                days[index % 7], // Display day names
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.grey[
                                          600], // Change color based on selection
                                ),
                              ),
                              // Date Text
                              Text(
                                '${dates[index]}',
                                style: TextStyle(
                                  color: isSelected ? Colors.white : Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              
              const SizedBox(height: 26.0),
              
              // Time Selection
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Selected Time: ${selectedTime != null ? "${selectedTime!.hour}:${selectedTime!.minute < 10 ? "0${selectedTime!.minute}" : selectedTime!.minute}" : "None"}",
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                    height: 40,
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () => _selectTime(context),
                      child: Text(
                        "Select Time",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 34.0),
              
              // Appointment Button
              _AppointmentCard(
                  selectedDay: selectedDay, selectedTime: selectedTime),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;

  const _InfoCard({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 4.0),
          Text(
            value,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  final int selectedDay;
  final TimeOfDay? selectedTime;

  const _AppointmentCard({
    required this.selectedDay,
    this.selectedTime,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 66, 165, 245), // Light blue
              Color.fromARGB(255, 41, 121, 255) // Dark blue
            ],
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Book an Appointment",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4.0),
              Text(
                "Selected Date: ${selectedDay > 0 ? selectedDay : "None"}",
                style: TextStyle(color: Colors.white70),
              ),
              Text(
                "Selected Time: ${selectedTime != null ? "${selectedTime!.hour}:${selectedTime!.minute < 10 ? "0${selectedTime!.minute}" : selectedTime!.minute}" : "None"}",
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
          Spacer(),
          Text(
            "Fee : 1000 ",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }
}
