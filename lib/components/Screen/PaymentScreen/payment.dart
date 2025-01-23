import 'dart:convert';
import 'package:app/components/Screen/MainBottomNavScreen.dart';
import 'package:app/components/Screen/home_pages.dart';
import 'package:app/components/Screen/PaymentScreen/keys.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Payment extends StatefulWidget {
  final String fees;
  const Payment({super.key, required this.fees});

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  late double amount;

  @override
  void initState() {
    super.initState();
    amount = double.tryParse(widget.fees) ?? 0.0;
  }

  Map<String, dynamic>? intantPaymentData;

showPaymentSheet() async {
  try {
    await Stripe.instance.presentPaymentSheet().then((val) {
      intantPaymentData = null;
      Get.to(()=>MainBottomNavScreen());
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

    // Show alert dialog if an error occurs
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Payment Failed"),
        content: Text("An error occurred during the payment process: $error"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Close"),
          ),
        ],
      ),
    );
  }
}


  makeIntentForPayment(double amountToBeCharge, String currency) async {
    try {
      int amountInCents = (amountToBeCharge * 100).toInt();

      Map<String, String> paymentInfo = {
        "amount": amountInCents.toString(),
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
          paymentIntentClientSecret: intantPaymentData!["client_secret"],
          style: ThemeMode.dark,
          merchantDisplayName: "riaz_ahmed_mahin",
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
      backgroundColor: Color.fromARGB(255, 224, 235, 251),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 224, 235, 251),
        title: Text("Stripe Payment Gateway", style: TextStyle(color: Colors.black)),
        elevation: 0,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 80.0,vertical: 50),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Total Payment Amount",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "TK : ${amount.toStringAsFixed(2)}",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        paymentSheetInitialization(
                          amount.roundToDouble(),
                          "BDT",
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                        backgroundColor: Colors.blueAccent,
                       // primary: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                        "Pay Now",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Text(
                "Your payment is secure with Stripe",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
