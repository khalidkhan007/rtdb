import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logindesign/Posts_screen/post_screen.dart';
//import 'package:logindesign/Posts/Posts_screen.dart';

import '../Widget/round_button.dart';
import '../calculator.dart';
import '../utile/utile.dart';
import 'Singup Screen.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});

  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  bool loading=false;
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
final _formkey =GlobalKey<FormState>();
FirebaseAuth _auth=FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  email.dispose();
  password.dispose();
  }

  void login(){
    setState(() {
      loading=true;
    });
    _auth.signInWithEmailAndPassword(
        email: email.text.toString(),
        password: password.text.toString()).then((value) {
Utils().toast(value.user!.email.toString());
//Navigator.push(
 // context,
  //MaterialPageRoute(builder: (context) => post_screen()),
//);
setState(() {
  loading =false;
});
    }).onError((error, stackTrace)
    {
      debugPrint(error.toString());
      Utils().toast(error.toString());
      setState(() {
        loading=false;
      });
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text("Sign In"),
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
                    login();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Calculator()),
                    );
                    }

                  },

                ),
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don not have any Account"),
                  TextButton(onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => sign_up_page (),));

                  }, child: Text("Signup")),
                ],
              ),

      ElevatedButton(onPressed: (){}, child: Text("exit"))
            ],

          ),
        ),
      ),

    );
  }
}
