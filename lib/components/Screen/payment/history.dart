import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PaymentHistoryScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Fetch payment history for the logged-in user
  Future<List<Map<String, dynamic>>> getPaymentHistory(String userId) async {
    List<Map<String, dynamic>> paymentHistory = [];

    var paymentRef = FirebaseFirestore.instance.collection('payments');
    var snapshot = await paymentRef.where('user_id', isEqualTo: userId).get();

    for (var doc in snapshot.docs) {
      paymentHistory.add(doc.data());
    }

    return paymentHistory;
  }

  @override
  Widget build(BuildContext context) {
    // Get the current user
    User? user = _auth.currentUser;

    if (user == null) {
      return Center(child: Text('Please log in to view your payment history.'));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment History'),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: getPaymentHistory(user.uid),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error fetching payment history'));
          }

          var payments = snapshot.data;

          if (payments == null || payments.isEmpty) {
            return Center(child: Text('No payment history found.'));
          }

          return ListView.builder(
            itemCount: payments.length,
            itemBuilder: (context, index) {
              var payment = payments[index];
              return ListTile(
                title: Text('Amount: ₹${payment['amount']}'),
                subtitle: Text('Date: ${payment['date']}'),
              );
            },
          );
        },
      ),
    );
  }
}
