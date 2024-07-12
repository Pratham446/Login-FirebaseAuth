import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/Pages/homepage.dart';
import 'package:login/Pages/signin.dart';

class signupp extends StatefulWidget {
  const signupp({super.key});

  @override
  State<signupp> createState() => _signuppState();
}

class _signuppState extends State<signupp> {


  final _formfield = GlobalKey<FormState>();
  final name=TextEditingController();

  final email=TextEditingController();
    final password=TextEditingController();
// step 1 with the help of authenticaion we are creating instance of our firebase and initializing it 
FirebaseAuth _auth =FirebaseAuth.instance; 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(key: _formfield,
              child: Column(
              children: [
                  TextFormField(
                                keyboardType: TextInputType.text,
                                controller: name,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter Name";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  label: Text("Name"),
                                  prefixIcon: Icon(Icons.email),
                                  hintText: "Enter Name",
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
                                ),),SizedBox(height: 13,),
                                 TextFormField(
                                keyboardType: TextInputType.emailAddress,
                                controller: email,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter Email";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  label: Text("Email"),
                                  prefixIcon: Icon(Icons.email),
                                  hintText: "Enter Email",
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
                                ),),
                                 SizedBox(height: 17,),
                                  TextFormField(obscureText: true,
                                keyboardType: TextInputType.text,
                                controller: password,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "Please Enter Password";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  label: Text("Password"),
                                  prefixIcon: Icon(Icons.email),
                                  hintText: "Password",
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
                                ),),

              ],
            ))
                                

                                                               

                             , ElevatedButton(
                              onPressed: _signUp, style:   TextButton.styleFrom( 
                        padding: EdgeInsets.all(8),backgroundColor: Colors.amber, shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(5.0),
              ),
                        
                      ), child: Text("Signup",style: TextStyle(color: Colors.white),)),
         SizedBox(
                        height: 17,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Alredy have an account ?"),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => signinn()));
                              },
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      )
          ],
        ),),
      ),
    );
  }
  Future<void> _signUp() async {
    if (_formfield.currentState!.validate()) {
      try {
        await _auth.createUserWithEmailAndPassword(
          
          email: email.text.trim(),
          password: password.text.trim(),
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => home()),
        );
        
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar( backgroundColor: Colors.red, content: Text("kindly fill proper detail",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
          )),
        );
      }
    }
  }
}