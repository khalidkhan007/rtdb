//import 'dart:js_interop';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logindesign/Posts_screen/Add_Posts.dart';
import 'package:logindesign/utile/utile.dart';

class AddData extends StatefulWidget {
  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final auth = FirebaseAuth.instance;
  final searchfilter = TextEditingController();
  final editcontroller = TextEditingController();
  final obj = FirebaseDatabase.instance.ref('Test');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("geeksforgeeks"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: TextFormField(
                controller: searchfilter,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: ("Search"),
                ),
                onChanged: (String value) {
                  setState(() {});
                }),
          ),
          Expanded(
            child: FirebaseAnimatedList(
              defaultChild: Text('Loading...'),
              query: obj,
              itemBuilder: (context, snapshot, animation, index) {
                final title = snapshot.child('Describtion').value.toString();
                if (searchfilter.text.isEmpty) {
                  return ListTile(
                    title: Text(snapshot.child('Describtion').value.toString()),
                    subtitle: Text(snapshot.child('id').value.toString()),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                            //showdialogbox (),
                            value: 1,
                            child: ListTile(
                              leading: Icon(Icons.edit),
                              onTap: () {
                                Navigator.pop(context);

                                showdialogbox(
                                    title, snapshot.child('id').value.toString());
                              },
                              title: Text("edit"),
                            )),
                        PopupMenuItem(
                            value: 1,
                            child: ListTile(
                              onTap: (){
                                Navigator.pop(context);
                                obj.child(snapshot.child("id").value.toString()).remove();
                              },
                              leading: Icon(Icons.delete),
                              title: Text("Delete"),
                            ))
                      ],
                      icon: Icon(Icons.more_vert),
                    ),
                  );
                } else if (title.toLowerCase().contains(searchfilter.text.toLowerCase().toLowerCase())) {
                  return ListTile(
                    title: Text(snapshot.child('Describtion').value.toString()),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
          Center(
            child: Text("hello dear "),
          ),
          FloatingActionButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return add_posts();
              },
            ));
          }),
        ],
      ),
    );
  }

  Future<void> showdialogbox(String atitle, String id) async {
    editcontroller.text = atitle;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Update"),
          content: Container(
            child: TextField(
              controller: editcontroller,
              decoration: InputDecoration(
                hintText: "Edit",
              ),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  obj.child(id).update({

                    'Describtion': editcontroller.text.toString(),
                  }).then((value) {
                    Utils().toast("Post Update");
                  }).onError((error, stackTrace) {
                    Utils().toast(error.toString());
                  });
                },
                child: Text("Update")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel")),
          ],
        );
      },
    );
  }
}
