import 'package:flutter/material.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:  Padding(
        padding: const EdgeInsets.only(left: 8.0, top: 8, bottom: 5, right: 8),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(),
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back,
              size: 20,
            ),
          ),
        ),
      ),
        //backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0,vertical: 12),
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(
              height: 200,width: 200,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 206, 216, 244),
                shape: BoxShape.circle,
                
              ),
              child: Image.network("https://cdn-icons-png.flaticon.com/128/1000/1000948.png",
              width: 10,
              height: 10,
              
              )
              ),
            SizedBox(height: 30),
            Text(
              "Please Enter Your Email to Receive a Verification Code",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black54,
              ),
            ),
            SizedBox(height: 50),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email/Phone',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            SizedBox(height: 30),
           
         
            ElevatedButton(
              onPressed: () {
                // Implement sending functionality
              },
              child: Text('Send'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 175, vertical: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }
}