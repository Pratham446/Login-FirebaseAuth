// For logout button 
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/Pages/signin.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  //step 1 initialize firebase instane  
  final auth =FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor: Colors.redAccent,actions: [
  IconButton(onPressed: (){
    //step 2 for SignOut 

    auth.signOut().then((value){Navigator.push(context, MaterialPageRoute(builder: (context)=>signinn()));
    });
  }, icon: Icon(Icons.logout_rounded,color: Colors.white,weight: 30,size: 25,),hoverColor:Colors.redAccent ,),
       Padding(
         padding: const EdgeInsets.all(8.0),
         child: Text("Logout",style:TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18) ,),
       ), ],
    ),
    );
  }
}