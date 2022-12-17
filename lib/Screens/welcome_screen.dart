import 'package:flutter/material.dart';
import 'package:phoneauth/Screens/register_screen.dart';
import 'package:phoneauth/Widgets/coustom_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 25 , horizontal: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Image.asset(
                    "assets/image1.png",
                  height: 300,
                ),

                SizedBox(height: 20,),

                Text(
                    "Let's get started",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 10),
                Text(
                  "Never better time than now to start.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black38,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: CustomButton(
                    onPressed: (){
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                          builder: (context)=> Register(),
                          ),
                      );
                    },
                    text: "Get started",
                  ),
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}
