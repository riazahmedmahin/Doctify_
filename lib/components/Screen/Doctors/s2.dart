import 'package:app/payment/payment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DoctorScheduleScreen extends StatefulWidget {
  final String slot;


  const DoctorScheduleScreen({super.key, required this.slot, });

  @override
  _DoctorScheduleScreenState createState() => _DoctorScheduleScreenState();
}

class _DoctorScheduleScreenState extends State<DoctorScheduleScreen> {
  DateTime _selectedDate = DateTime.now();
  late List<DateTime> _datesToShow;
  late String selectedSlot;

  @override
  void initState() {
    super.initState();
    _datesToShow = _getNext7Days(DateTime.now());
    _startAutoUpdate();
    selectedSlot = widget.slot;
  }

  List<DateTime> _getNext7Days(DateTime startDate) {
    return List.generate(7, (index) => startDate.add(Duration(days: index)));
  }

  String _getMonthName(DateTime date) {
    return DateFormat('MMMM').format(date);
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd').format(date);
  }

  String _getWeekday(DateTime date) {
    return DateFormat('EEE').format(date);
  }

  void _startAutoUpdate() {
    Future.delayed(Duration.zero, () {
      Future.doWhile(() async {
        await Future.delayed(const Duration(hours: 24));
        DateTime currentDate = DateTime.now();
        if (currentDate.day > _datesToShow[0].day) {
          setState(() {
            _selectedDate = currentDate;
            _datesToShow = _getNext7Days(currentDate);
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
        backgroundColor: const Color.fromARGB(255, 224, 235, 251),
        elevation: 0,
        title: const Text('Doctor Schedule'),
      ),
      backgroundColor: const Color.fromARGB(255, 224, 235, 251),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 7,
                itemBuilder: (context, index) {
                  DateTime day = _datesToShow[index];
                  bool isSelected = _selectedDate.isSameDay(day);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedDate = day;
                      });
                    },
                    child: Container(
                      width: 72,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: isSelected
                            ? const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 5, 93, 245),
                            Color.fromARGB(255, 66, 165, 245),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        )
                            : const LinearGradient(
                          colors: [
                            Color.fromARGB(255, 224, 235, 251),
                            Color.fromARGB(255, 187, 216, 250),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 8,
                            offset: const Offset(2, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _getWeekday(day),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _formatDate(day),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _getMonthName(day),
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: isSelected ? Colors.white : Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Available Slots:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              height: 40,
              width: 100,
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(6),
              ),
              child: Center(
                child: Text(
                  selectedSlot,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              height: 70,
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                 Color.fromARGB(255, 5, 93, 245),
                            Color.fromARGB(255, 79, 167, 239),
                    ],
                  // begin: Alignment.topLeft,
                    //end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ElevatedButton(
                  
                  style: ElevatedButton.styleFrom(
                    //elevation: 0, // Remove shadow to blend with gradient
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    ),
                    backgroundColor: Color.fromARGB(255, 22, 108, 207), // Transparent to show gradient
                  ),
                  onPressed: () {
                    //Get.to(() => Payment(fees: fees,));
                    // Handle booking logic
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(width: 5),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Book Appointment",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text(
                            "${_formatDate(_selectedDate)} ${_getMonthName(_selectedDate)} (${_getWeekday(_selectedDate)}) - $selectedSlot",
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(width: 6),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension DateComparison on DateTime {
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
