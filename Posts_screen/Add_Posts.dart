import 'package:flutter/material.dart';
import 'package:logindesign/Widget/round_button.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:logindesign/utile/utile.dart';

class add_posts extends StatefulWidget {
  const add_posts({super.key});

  @override
  State<add_posts> createState() => _add_postsState();
}

class _add_postsState extends State<add_posts> {
bool isloading =false;
  final databaseref=FirebaseDatabase.instance.ref('Test');
final postcontroller=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("add Posts"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
SizedBox(
  height: 30,
),
            TextFormField(
              controller: postcontroller,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "What is in your mind",
              border: OutlineInputBorder(),
              ),

            ),
            SizedBox(
              height: 30,
            ),
            round_button(title: "Add",
                loading: isloading,
                ontap:(){
              setState(() {
                isloading=true;
              });
              String id=DateTime.now().millisecondsSinceEpoch.toString();
              databaseref.child(id).set({
                "Describtion":postcontroller.text.toString(),
                "id":id,
                'sirname':"khalid",
              }
              ).then((value){
                setState(() {
                  isloading=false;

                });
                Utils().toast("post add");

              }).onError((error, stackTrace){
                setState(() {
                  isloading =true;
                });
                Utils().toast(error.toString());
              });
            }),
          ],
        ),
      ),
    );
  }
}
