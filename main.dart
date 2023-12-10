//import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Posts_screen/post_screen.dart';
import 'calculator.dart';
import 'firebase_options.dart';
import 'Login/loginpage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform).catchError((e){
    print(" Error : ${e.toString()}");
  });
  runApp(MyApp());
}
class MyApp extends StatelessWidget {

  const MyApp({super.key});
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
  debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
theme: ThemeData(

 // primaryColor: Colors.orange,
),
      home:AddData(),
      //Calculator(),
      //loginpage(),
    );
  }
}
