import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  var output = "";
  var input = "";
  var previousAnswer = 0.0;
  var hideInput = false;
  var outputSize = 34.0;

  void onPressBtn(value) {
    if (value == "AC") {
      output = '';
      input = '';
      previousAnswer = 0.0;
    } else if (value == "=") {
      if (input.isNotEmpty) {
        var userInput = input;
        Parser p = Parser();
        Expression expression = p.parse(userInput);
        ContextModel cm = ContextModel();
        var finalValue = expression.evaluate(EvaluationType.REAL, cm);
        previousAnswer = finalValue;
        hideInput = true;
        output = finalValue.toString();
        if (output.endsWith('.0')) {
          output = output.substring(0, output.length - 2);
        }
        if (output.length > 1) {
          outputSize = 24.0;
        } else {
          outputSize = 34.0;
        }
      }
    } else if (value == "<") {
      if (input.isNotEmpty) {
        input = input.substring(0, input.length - 1);
      }
    } else if (value == "+" || value == "-" || value == "*" || value == "/") {
      // Check if the user pressed an operator after obtaining the result
      if (hideInput) {
        // Use the previous answer as the starting point for the new expression
        input = previousAnswer.toString();
        hideInput = false;
      }
      input += value;
    } else {
      input += value;
      // Update the output variable with the current input
      output = input;
      // Show the input since a new digit or operator is being added
      hideInput = false;
    }

    // Trigger a rebuild of the widget to update the displayed text
    setState(() {
      input;
      output;
    });
  }

  Widget calculbutton(String txtBtn, Color txtColor) {
    return Container(
      child: ElevatedButton(
        onPressed: () {
          onPressBtn(txtBtn);
        },
        child: Text(
          txtBtn,
          style: TextStyle(
            fontSize: 35,
            color: txtColor,
          ),
        ),
        style: ElevatedButton.styleFrom(
          shape: CircleBorder(),
          padding: EdgeInsets.all(10.0),
          fixedSize: Size(80, 80),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:Drawer(child: ListView(
        children: [
          DrawerHeader(
            curve: Curves.bounceIn,
            decoration: BoxDecoration(
              color: Colors.white

            ), child: ClipOval(
              child: CircleAvatar(
                radius: 50.0, // Adjust the radius as needed
                //backgroundImage: AssetImage('assets/images/2.jpeg'), // Replace with your image path
                child: Image(
                  fit: BoxFit.cover, image:AssetImage('assets/images/2.jpeg'),   // Maintain the aspect ratio and cover the entire circle
                ),
              ),
            ),
          ),
        ListTile(

          title: Text(" Back"),
          onTap: (){
            Navigator.pop(context);
          },
        )

        ],

      ),
        backgroundColor: Colors.orangeAccent,
      ),
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.orange,
        title: Text(
          "Calculator",
          style: TextStyle(fontSize: 30, color: Colors.white),
        ),
        centerTitle: true,
      ),

      body: Container(
        color: Colors.orangeAccent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  SizedBox(height: 10),
                  Text(hideInput ? "" : input, style: TextStyle(fontSize: 55)),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                textDirection: TextDirection.rtl,
                children: [
                  SizedBox(height: 10),
                  Text(
                    "$output",
                    style: TextStyle(fontSize: outputSize),
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 1,
              color: Colors.grey[600],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: calculbutton("AC", Colors.white)),
                Expanded(child: calculbutton("<", Colors.white)),
                Expanded(child: calculbutton("%", Colors.white)),
                Expanded(child: calculbutton("/", Colors.white)),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: calculbutton("7", Colors.white)),
                Expanded(child: calculbutton("8", Colors.white)),
                Expanded(child: calculbutton("9", Colors.white)),
                Expanded(child: calculbutton("*", Colors.white)),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: calculbutton("4", Colors.white)),
                Expanded(child: calculbutton("5", Colors.white)),
                Expanded(child: calculbutton("6", Colors.white)),
                Expanded(child: calculbutton("-", Colors.white)),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(child: calculbutton("1", Colors.white)),
                Expanded(child: calculbutton("2", Colors.white)),
                Expanded(child: calculbutton("3", Colors.white)),
                Expanded(child: calculbutton("+", Colors.white)),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      "0",
                      style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        padding: EdgeInsets.only(
                            left: 39, top: 10, right: 110, bottom: 20))),
                calculbutton(".", Colors.white),
                calculbutton("=", Colors.white),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
