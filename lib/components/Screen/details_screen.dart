import 'package:flutter/material.dart';

class DoctorDetailsPage extends StatelessWidget {
  final String name;
  final String specialty;
  final String hospital;
  final String rating;
  final String image;
  final String description;
  final String qualification;

  const DoctorDetailsPage({
    Key? key,
    required this.name,
    required this.specialty,
    required this.hospital,
    required this.rating,
    required this.image,
    required this.description,
    required this.qualification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Image
            Center(
              child: CircleAvatar(
                backgroundImage: NetworkImage(image),
                radius: 60,
                backgroundColor: Colors.blueGrey[50],
              ),
            ),
            SizedBox(height: 20),

            // Doctor Name
            Center(
              child: Text(
                name,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            SizedBox(height: 8),

            // Specialty and Hospital
            Center(
              child: Text(
                specialty,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: Colors.blueGrey[600],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Rating Row
            Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Rating: $rating",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.star, color: Colors.amber, size: 20),
                ],
              ),
            ),
            SizedBox(height: 20),

            // Hospital
            Text(
              "Hospital",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 5),
            Text(
              hospital,
              style: TextStyle(
                fontSize: 18,
                color: Colors.blueGrey[600],
              ),
            ),
            SizedBox(height: 20),

            // Qualification
            Text(
              "Qualification",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 5),
            Text(
              qualification,
              style: TextStyle(
                fontSize: 18,
                color: Colors.blueGrey[600],
              ),
            ),
            SizedBox(height: 20),

            // Description
            Text(
              "Description",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 5),
            Text(
              description,
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 30),

            // Book Appointment Button
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  print('Book appointment with $name');
                },
                icon: Icon(Icons.calendar_today, color: Colors.white),
                label: Text(
                  'Book Appointment',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
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
