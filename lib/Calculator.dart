import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);


  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {

  String userInput = " ";
  String result = "0";

  List<String> listButton = [
    'AC', '(', ')', '/', '7', '8', '9', '*', '4', '5', '6',
    '-', '1', '2', '3', '+', '0', '.', 'C', '='
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color.fromRGBO(15, 15, 15, 1),
      body: Column(

        children: [

          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  Container(
                    padding: EdgeInsets.only(right: 40, top: 80),
                    alignment: Alignment.centerRight,
                    child: Text(
                      userInput,
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.white
                      ),),

                  ),

                  Container(

                    padding: EdgeInsets.all(30),
                    alignment: Alignment.bottomRight,
                    child: Text(
                      result ,
                      style: TextStyle(
                          fontSize: 70,
                          color: Colors.white
                      ),),

                  ),



                ],
              ),
            )
          ),

          Expanded(
              child: Container(
                  padding: EdgeInsets.all(10),
                  child: GridView.builder(
                    itemCount: listButton.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      return CustomButton(listButton[index]);
                    },
                  )
              )
          )
        ],
      ),
    );
  }

  Widget CustomButton(String text) {
    return InkWell(
      onTap: () {
        setState(() {
          handleButtons(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
          color: getBackgroundColor(text),
          borderRadius: BorderRadius.circular(70)
        ),
        child: Center(
          child: Text(text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 26,
          ),),
        ),
      ),
    );
  }

  getBackgroundColor(String text) {
    if(text == "AC" || text == "(" || text == ")")
      {
        return Color.fromRGBO(35, 33, 33, 1);
      }
    else if(text == "/" || text == "*" || text == "-" || text == "+" || text == "=" || text == "%")
    {
      return Color.fromRGBO(232, 142, 38, 1);
    }
    
    return Color.fromRGBO(81, 78, 78 , 1);
  }

  handleButtons(String text) {
    if(text == "AC") {
      userInput = " " ;
      result = "0";
      return;

    } else if(text == "C") {
      if(userInput.isNotEmpty) {
        userInput = userInput.substring(0,userInput.length - 1);
        return;
      }else{
        return null;
      }
    }

    if(text == "=") {
      result = calculate();
      userInput = result;
      
      if(userInput.endsWith(".0")){
        userInput = userInput.replaceAll(".0", " ");
      }

      if(result.endsWith(".0")){
        result = result.replaceAll(".0", " ");
      }

      return null;

    }

    if(userInput.endsWith("/") || userInput.endsWith("*") || userInput.endsWith("-") || userInput.endsWith("+")) {
      if(text == "*") {
        userInput = userInput.replaceAll("/", "*");
        userInput = userInput.replaceAll("-", "*");
        userInput = userInput.replaceAll("+", "*");
        return null;

      }else if(text == "/") {
        userInput = userInput.replaceAll("*", "/");
        userInput = userInput.replaceAll("-", "/");
        userInput = userInput.replaceAll("+", "/");
        return null;

      }else if(text == "-") {
        userInput = userInput.replaceAll("/", "-");
        userInput = userInput.replaceAll("*", "-");
        userInput = userInput.replaceAll("+", "-");
        return null;

      }else if(text == "+") {
        userInput = userInput.replaceAll("/", "+");
        userInput = userInput.replaceAll("*", "+");
        userInput = userInput.replaceAll("-", "+");

        return null;

      }
    }




    userInput = userInput + text;


  }

  String calculate() {
    try{
      var exp = Parser().parse(userInput);
      var evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    }
    catch(e){
      return "Error";
    }
  }

}
