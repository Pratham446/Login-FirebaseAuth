import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login/Number%20Authentication/verifynumber.dart';

class lg extends StatefulWidget {
  const lg({super.key});

  @override
  State<lg> createState() => _lgState();
}

class _lgState extends State<lg> {
  final numberrcontroller = TextEditingController();
  // Step 1

  FirebaseAuth _auth = FirebaseAuth.instance;

  // Step 2 verify Phoneno  Format
  void _verifyPhoneNumber() async {
     
     //Created a variable of Number which will use to validate downwards
    String phoneNumber = numberrcontroller.text.trim();

    // Ensure the phone number starts with +91
    if (!phoneNumber.startsWith('+91')) {
      phoneNumber = '+91$phoneNumber';
    }

     if (phoneNumber.length != 13) {
      Fluttertoast.showToast(
        msg: "Invalid phone number format",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      return;
    }
    
    // Step 3 fetching the number from the user --user se phonenumber le liya

    try {
                   await _auth.verifyPhoneNumber(
phoneNumber: numberrcontroller.text.trim(),
// Step 4 Verification Complete

verificationCompleted: (PhoneAuthCredential credential) {},

 
 //Step 5 Verification Fail
  verificationFailed: (FirebaseAuthException e) {
          Fluttertoast.showToast(
            msg: "Verification failed: ${e.message}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          print("Verification failed: ${e.code} - ${e.message}");
        },

//Step 6   code sent which will take string verification id and integer token will be sent to user
//after that we have to use verification id in verifynumber page for verifcation when user will enter otp
//so will send request to firebsase server to verify

 codeSent: (String verificationId, int? resendToken) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Verifynumber(verificationid: verificationId),
            ),
          );
        },

//Step 7 Session Expired
        codeAutoRetrievalTimeout: (String verificationId) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            backgroundColor: Colors.red,
            content: Text(
              "Session Expired",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ));
        },
);
    } catch (e) {
       Fluttertoast.showToast(
        msg: "An error occurred: ${e.toString()}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print("An error occurred: $e");
    }

  }








  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                controller: numberrcontroller,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your number";
                  }
                  return null;
                },
                decoration: InputDecoration(
                  label: Text("Number"),
                  prefixIcon: Icon(Icons.phone),
                  hintText: "Please enter +91",
                  hintStyle: TextStyle(color: Colors.black),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.purple),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.grey,
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(),
                ),
                onPressed: _verifyPhoneNumber,
                child: Text(
                  "Login",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
