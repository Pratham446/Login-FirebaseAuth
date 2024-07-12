// import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/Number%20Authentication/verifynumber.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Loginwithphone extends StatefulWidget {
  const Loginwithphone({super.key});

  @override
  State<Loginwithphone> createState() => _LoginwithphoneState();
}

class _LoginwithphoneState extends State<Loginwithphone> {
  final number = TextEditingController();
  //step 1 initialize firebase
  FirebaseAuth _auth = FirebaseAuth.instance;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextFormField(
            // obscureText: true,
            keyboardType: TextInputType.number,
            controller: number,
           validator: (value) {
  if (value == null || value.isEmpty) {
    return "Please enter your number";
  }
  return null;
},
            decoration: InputDecoration(
              label: Text("Number"),
              prefixIcon: Icon(Icons.email),
              hintText: "Number",
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
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: 
                 ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.grey,
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(),
                    ),
                    onPressed: ()async {
                      //Step 2  fetching the number from the user --user se phonenumber le liya
                   await _auth.verifyPhoneNumber(
phoneNumber: number.text.trim(),

                       //Step 3   verification complete -> firebase pe request bhej di

                          verificationCompleted: (PhoneAuthCredential credential) {},

                       //Step 4 verification fail 

                          verificationFailed: (e) {
                            Fluttertoast.showToast(
          msg: "Verification failed: ${e.message}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
                                  print("Verification failed: ${e.code} - ${e.message}");

                          },
         //Step 5   code sent which will take string verification id and integer token will be sent to user
//after that we have to user verification id in verifynumber page when for verifcation when user will enter otp
//so will send request to firebsase server to verify
                          codeSent: (String Verificationid, int? token) {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Verifynumber(verificationid: Verificationid,)));
                          },

                //Step 6   timeout 
                          codeAutoRetrievalTimeout: (String verificationId) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                  "Session Expired",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )));
                          });
                    },
                    child: Text(
                      "login",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
          ),
        ),
      ],
    ));
  }
}
