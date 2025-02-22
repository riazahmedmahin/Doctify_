import 'package:flutter/material.dart';

class Upcommingcard extends StatelessWidget {
  const Upcommingcard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        padding: EdgeInsets.all(12),
        width: double.infinity,
        height: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: const LinearGradient(
            colors: [Color(0xFF398AE5), Color(0xFF6a85b6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: ClipOval(
                      child: Image.network(
                        'https://images.unsplash.com/photo-1622253692010-333f2da6031d?w=800&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZG9jdG9yJTIwcHJvZmlsZXxlbnwwfHwwfHx8MA%3D%3D',
                        width: 50, // Same as 2 * radius of CircleAvatar
                        height: 50,
                        fit: BoxFit
                            .fill, // Ensures image covers the whole circle
                      ),
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Dr. Ariful Islam',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                      Text('Cardiologist - City Hospital',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                          )),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, bottom: 15),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: const [
                          Text(
                            '4.5',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Icon(Icons.star, color: Colors.amber, size: 18),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8, left: 80),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.calendar_month_outlined, color: Colors.white),
                    SizedBox(width: 8),
                    Text('Today, 05:00 PM',
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    //SizedBox(height: 0,),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
