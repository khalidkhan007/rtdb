//import 'dart:html';
//import 'package:fluttertoast/fluttertoast.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_storage/firebase_storage.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:logindesign/utile/utile.dart';
import '../Widget/round_button.dart';
import 'loginpage.dart';

class sign_up_page extends StatefulWidget {
  const sign_up_page({super.key});

  @override
  State<sign_up_page> createState() => _sign_up_pageState();
}
class _sign_up_pageState extends State<sign_up_page> {
  bool loading= false;
  FirebaseAuth _auth=FirebaseAuth.instance;
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  final _formkey =GlobalKey<FormState>();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    password.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Sign Up"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Form(
              key: _formkey,
              child:Column(
                children: [
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: "Email",
                      icon: Icon(Icons.email),
                    ),
                    controller:email ,
                    validator: (value){
                      if(value!.isEmpty){
                        return "Enter Email";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 20,),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Password",
                      icon: Icon(Icons.lock),

                    ),
                    controller:password ,
                    validator: (value){
                      if(value!.isEmpty){
                        return "enter password";
                      }
                      return null;

                    },
                  ),
                  SizedBox(height: 50,),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: round_button(
                title: "Login",
                loading: loading,
                ontap: (){
                  if(_formkey.currentState!.validate()){
                    setState((){
                      loading = true;
                    });
                  _auth.createUserWithEmailAndPassword(
                      email: email.text.toString(),
                      password: password.text.toString()).then((value) {

                        setState((){
                          loading =false;
                        });


                  }).onError((error, stackTrace) {
                        setState((){
                          loading =false;
                        });
                      Utils().toast(error.toString());
                  });
                  
                  }

                },

              ),
            ),
            SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don  have any Account"),
                TextButton(onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => loginpage(),));

                }, child: Text("SignIn")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
