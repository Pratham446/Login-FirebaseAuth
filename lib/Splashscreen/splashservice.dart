// we have created a function splashservice which will redirect to signin page
import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:login/Pages/homepage.dart';
import 'package:login/Pages/signin.dart';


class Splashservice{
  void islogin(BuildContext context){
// now this will check wheather user is new or already login accoring to that it will work

  //step 1 - creating firebase authentication Instance
  final auth =FirebaseAuth.instance;

  //step 2 - this authentication will return current user details which is already login 
  final user=auth.currentUser;

  // Step 3 check condition if user detail is null or already login 

  if (user!=null) {
       Timer(Duration(seconds: 3), ()=>Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>home())));
  }
else{
    Timer(Duration(seconds: 3), ()=>Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>signinn())));
}
  }
}