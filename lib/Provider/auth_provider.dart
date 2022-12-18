import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phoneauth/Screens/otp_screen.dart';
import 'package:phoneauth/Utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier{

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  AuthProvider(){
    CheckSignIn();
  }

  void CheckSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("is_signedin") ?? false;
    notifyListeners();
  }

  void SignInWithPhone(BuildContext context, String phoneNumber) async {
    try{
      await _firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async{
            await _firebaseAuth.signInWithCredential(phoneAuthCredential);
          },
          verificationFailed: (error){
            throw Exception(error.message);
          },
          codeSent: (verificationId, forceResendingToken){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => OtpScreen(verificationId: verificationId)
            ),);
          },
          codeAutoRetrievalTimeout: (verificationId){} );
    } on FirebaseAuthException
    catch(e){
      ShowSnackBar(context,e.message.toString());
    }
  }
}