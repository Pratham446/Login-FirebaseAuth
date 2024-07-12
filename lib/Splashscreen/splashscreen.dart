import 'package:flutter/material.dart';
import 'package:login/Splashscreen/splashservice.dart';
// import 'package:login/splashservice.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
      Splashservice splash=Splashservice();  //step 1 initialize of our service class

  @override
  void initState() {
    
    super.initState();
    splash.islogin(context);   //  Step 2 we will call initstate inside then whenever user comes to splash screen 
  }                            //this condition will check
  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: Colors.red,
      body: Center(
        child: Text('Welcome user' , style: TextStyle(fontSize: 37,color: Colors.white),),
      ),
    );
  }
}