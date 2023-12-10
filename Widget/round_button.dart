import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class round_button extends StatelessWidget {
  final String title;
  final  ontap;
   final bool loading;

  const round_button({super.key, 
    required this.title,
    required this.ontap,
    this.loading=false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius:BorderRadius.circular(10),
        ),
        child: Center(
          child:loading ?CircularProgressIndicator(color: Colors.white,): Text(title,style: TextStyle(color: Colors.white),),

        ),
      ),
    );
  }
}
