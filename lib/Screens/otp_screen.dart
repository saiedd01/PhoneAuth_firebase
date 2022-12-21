import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phoneauth/Provider/auth_provider.dart';
import 'package:phoneauth/Screens/home_screen.dart';
import 'package:phoneauth/Utils/utils.dart';
import 'package:phoneauth/Widgets/coustom_button.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:phoneauth/Screens/user_info.dart';

class OtpScreen extends StatefulWidget {
  final String verificationId;
  const OtpScreen({Key? key, required this.verificationId}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String? OtpCode;
  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<AuthProvider>(context , listen: true).isLoading;
    return Scaffold(
        body: SafeArea(
            child: isLoading== true
                ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.purple,
                ),
            ):
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 25 , horizontal: 10),
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
                          "assets/image3.png",
                        ),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "Verification",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "Enter the OTP send to your phone number ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black38, fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Pinput(
                        length: 6,
                        showCursor: true,
                        defaultPinTheme: PinTheme(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.purple.shade300)
                          ),
                          textStyle: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onCompleted: (value){
                          setState(() {
                            OtpCode = value;
                          });
                          print(OtpCode);
                        },
                      ),
                      SizedBox(height:20),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: CustomButton(
                          text: 'Verify',
                          onPressed: () {
                            if(OtpCode != null){
                              verifyOtp(context, OtpCode!);
                            }
                            else{
                              ShowSnackBar(context, "Enter 6-Digit code");
                            }
                          },
                        ),
                      ),
                      SizedBox(height: 20,),
                      Text("Didn't receive any code? ",
                        style: TextStyle(
                          fontSize:14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38,
                        ),
                      ),
                      SizedBox(height: 15,),
                      Text(
                        "Resend New Code",
                        style: TextStyle(
                          fontSize:16,
                          fontWeight: FontWeight.bold,
                          color: Colors.purple,
                        ),
                      ),
                    ]
                ),
              ),
            ),
        ),
    );
  }
  void verifyOtp(BuildContext context, String userOtp){
    final pre = Provider.of<AuthProvider>(context , listen: false);
    pre.verifyOtp(
        context: context,
        verificationId: widget.verificationId,
        userOtp: userOtp,
        onSuccess: (){
          pre.checkExitingUser().then((value) async{
            if (value == true){
              // user exits in app
              pre.getDataFromFirestore().then((value) =>
                  pre.saveUserDataToSp().then((value) =>
                      pre.setSignIn().then((value) =>
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) => Home(),),
                              (route) => false),),),);
            }
            else{
              // new user
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                  builder: (context)=> const UserInformation()),
                      (route) => false);
            }
          },
          );
    },
    );
  }
}
