import 'package:flutter/material.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 25 , horizontal: 30),
                child: Column(
                    children:[
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: ()=> Navigator.of(context).pop(),
                          child: Icon(Icons.arrow_back),
                        ),
                      ),
                      Container(
                        width: 200,
                        height: 200,
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.purple.shade50,
                        ),
                        child: Image.asset(
                          "assets/image2.png",
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Register",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Add your phone number. we'll send you a verification code",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black38, fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                    ]
                ),
              ),
            ),
        ),
    );
  }
}
