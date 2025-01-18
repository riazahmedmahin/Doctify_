import 'dart:convert';
import 'package:app/payment/keys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class Payment extends StatefulWidget {
  final String fees;
  const Payment({super.key, required this.fees});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  late double amount;  // Declare the amount as a double

  @override
  void initState() {
    super.initState();
    // Convert the string 'fees' to a double value for the payment calculation
    amount = double.tryParse(widget.fees) ?? 0.0;  // Default to 0.0 if parsing fails
  }

  Map<String, dynamic>? intantPaymentData;

  showPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet().then((val) {
        // Reset after successful payment
        intantPaymentData = null;
        // You can handle success logic here if needed
      }).onError((error, stackTrace) {
        if (kDebugMode) {
          print("Debugging info: $stackTrace");
        }
        print("Error occurred: $error");
      });
    } on StripeException catch (error, stackTrace) {
      if (kDebugMode) {
        print("Debugging info: $stackTrace");
      }
      print("Error occurred: $error");
    }
  }

  makeIntentForPayment(double amountToBeCharge, String currency) async {
    try {
      // Convert amount to cents (integer) for Stripe API
      int amountInCents = (amountToBeCharge * 100).toInt();  // Ensure it's an integer

      Map<String, String> paymentInfo = {
        "amount": amountInCents.toString(),  // Convert the integer to a string for the API call
        "currency": currency,
        "payment_method_types[]": "card",
      };

      var responseFromStripeApi = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        body: paymentInfo,
        headers: {
          "Authorization": "Bearer $Secretkey",
          "Content-Type": "application/x-www-form-urlencoded",
        },
      );

      print("Response from Stripe API: " + responseFromStripeApi.body);

      if (responseFromStripeApi.statusCode == 200) {
        return jsonDecode(responseFromStripeApi.body);
      } else {
        throw Exception("Failed to create payment intent: ${responseFromStripeApi.body}");
      }
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print("Debugging info: $stackTrace");
      }
      print("Error occurred during payment intent creation: $error");

      // Show an error dialog in case of a failure
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text("Intent Creation Error"),
          content: Text("An error occurred: $error"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
        ),
      );
    }
  }

  paymentSheetInitialization(double amountToBeCharge, String currency) async {
    try {
      intantPaymentData = await makeIntentForPayment(amountToBeCharge, currency);
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          allowsDelayedPaymentMethods: true,
          paymentIntentClientSecret: intantPaymentData!["client_secret"], // Correct field
          style: ThemeMode.dark,
          merchantDisplayName: "Your Company Name",
        ),
      ).then((val) {
        print(val);
      });
      showPaymentSheet();
    } catch (error, stackTrace) {
      if (kDebugMode) {
        print("Debugging info: $stackTrace");
      }
      print("Error occurred: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stripe Payment Gateway")),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 400),
            ElevatedButton(
              onPressed: () {
                paymentSheetInitialization(
                  amount.roundToDouble(), // Corrected here to pass a double
                  "USD", // Pass the currency as a string
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              child: Text("Pay Now \$${amount.toStringAsFixed(2)}"),
            ),
          ],
        ),
      ),
    );
  }
}
