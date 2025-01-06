import 'package:flutter/material.dart';

class DoctorDetailsPage extends StatelessWidget {
  final String name;
  final String specialty;
  final String hospital;
  final String rating;
  final String image;

  const DoctorDetailsPage({
    Key? key,
    required this.name,
    required this.specialty,
    required this.hospital,
    required this.rating,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(image),
              radius: 50,
            ),
            SizedBox(height: 20),
            Text(
              name,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "Specialty: $specialty",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Text(
              "Hospital: $hospital",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Text(
                  "Rating: $rating",
                  style: TextStyle(fontSize: 18),
                ),
                Icon(Icons.star, color: Colors.amber),
              ],
            ),
            SizedBox(height: 20),
            Text("Description"),
            
            ElevatedButton(
              onPressed: () {
                // Handle the appointment booking functionality
                print('Book appointment with $name');
              },
              child: Text('Book Appointment'),
            ),
          ],
        ),
      ),
    );
  }
}
