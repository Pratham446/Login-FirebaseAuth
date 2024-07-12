import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:login/Pages/homepage.dart';

class Verifynumber extends StatefulWidget {
  final String verificationid;
  const Verifynumber({super.key, required this.verificationid});

  @override
  State<Verifynumber> createState() => _VerifynumberState();
}

class _VerifynumberState extends State<Verifynumber> {
  final otpcontroller = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  // Now will verify token
  void verify() async {
    final token = PhoneAuthProvider.credential(
        verificationId: widget.verificationid,
        smsCode: otpcontroller.text.toString());

    try {
      await _auth.signInWithCredential(token);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (Context) => home()));
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Verification failed",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      print("Verification failed");
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
              controller: otpcontroller,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please enter your OTP";
                }
                return null;
              },
              decoration: InputDecoration(
                label: Text("6 Digit Code"),
                prefixIcon: Icon(Icons.code),
                hintText: "Please enter OTP",
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
          SizedBox(height: 15,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shadowColor: Colors.grey,
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(),
                ),
                onPressed: verify,
                child: Text(
                  "Verify",
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
