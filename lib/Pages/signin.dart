import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:login/Number%20Authentication/LoginWithPhon.dart';
// import 'package:login/Number%20Authentication/loginwithphone.dart';
import 'package:login/Pages/homepage.dart';
import 'package:login/Pages/signup.dart';

class signinn extends StatefulWidget {
  const signinn({super.key});

  @override
  State<signinn> createState() => _HomepageState();
}

class _HomepageState extends State<signinn> {
  //textediting controller is  usedto get the current value of the text field, listen to changes, and update the text field programmatically.

  final email=TextEditingController();
    final password=TextEditingController();

  final _formfield = GlobalKey<FormState>();
  //A GlobalKey<FormState> is created and assigned to _formKey.
  //The ElevatedButton uses _formfield.currentState?.validate() to check if the form is valid when the button is pressed.

// step 1 with the help of authenticaion we are creating instance of our firebase and initializing it 
FirebaseAuth _auth =FirebaseAuth.instance; 
    @override
  void dispose() { //dispose means jab yea screen nai rahegi toh app memory meh se dispose kar do release kardo
    
    super.dispose();
    email.dispose();
    password.dispose();
  }

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
            )),
                                SizedBox(height: 12,)

                                                               

                             , ElevatedButton(onPressed: _signin, style:   TextButton.styleFrom( 
                        padding: EdgeInsets.all(8),backgroundColor: Colors.amber, shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(5.0),
              ),
                        
                      ), child: Text("Signin",style: TextStyle(color: Colors.white),)),
         SizedBox(
                        height: 17,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Dont have an account ?"),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => signupp()));
                              },
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold),
                              ))
                        ],
                      ),
                      SizedBox(height: 15,),
                      InkWell(onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>lg()));
                      },
                        child: Container(decoration: BoxDecoration(border: Border.all(color: Colors.black,),borderRadius:BorderRadius.circular(25) ),
                          child: Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text("Login with Phone",style: TextStyle(fontSize: 21),),
                          ),),
                      )
          ],
        ),),
      ),
      
    );
  }
  Future<void> _signin() async{
if (_formfield.currentState!.validate()) {
  try {
    //step 2
    await _auth.signInWithEmailAndPassword(email: email.text, password: password.text);
     Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => home()),
        );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar( backgroundColor: Colors.red, content: Text("Password is Invalid or email dosent exist",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
          )),);
  }
}
  }
}