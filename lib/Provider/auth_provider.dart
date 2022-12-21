import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:phoneauth/Model/user_model.dart';
import 'package:phoneauth/Screens/otp_screen.dart';
import 'package:phoneauth/Utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier{

  bool _isSignedIn = false;
  bool get isSignedIn => _isSignedIn;
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  String? _uid;
  String get uid => _uid!;
  UserModel? _userModel;
  UserModel get userModel => _userModel!;

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  AuthProvider(){
    CheckSignIn();
  }

  void CheckSignIn() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isSignedIn = s.getBool("is_signedin") ?? false;
    notifyListeners();
  }

  Future setSignIn() async{
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("is_signedin", true);
    _isSignedIn = true;
    notifyListeners();
  }
  // signIn
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

  // verify OTP
  void verifyOtp({
    required BuildContext context,
    required String verificationId,
    required String userOtp,
    required Function onSuccess,
  }) async{
    _isLoading = true;
    notifyListeners();
    try{
      PhoneAuthCredential Creds = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: userOtp);
      User? user = (await _firebaseAuth.signInWithCredential(Creds)).user!;

      if(user != null){
        _uid = user.uid;
        onSuccess();
      }
      _isLoading = false;
      notifyListeners();
    } on FirebaseAuthException catch(e){
      ShowSnackBar(context,e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  //DataBase Opertaion
  Future<bool> checkExitingUser() async{
    DocumentSnapshot snapshot =
    await _firebaseFirestore.collection("user").doc(_uid).get();
    if(snapshot.exists){
      print("USER EXITS");
      return true;
    }
    else{
      print("NEW USER");
      return false;
    }
  }

  // save data
  void saveUserDataToFirebase({
    required BuildContext context,
    required UserModel userModel,
    required File profilePic,
    required Function onSuccess,
  }) async{
    _isLoading = true;
    notifyListeners();
    try{
      // Upload image
      await storeFileToStorage("profilePic/$_uid", profilePic).then((value){
        userModel.profilePic = value;
        userModel.createdAt = DateTime.now().microsecondsSinceEpoch.toString();
        userModel.phoneNumber = _firebaseAuth.currentUser!.phoneNumber!;
        userModel.uid = _firebaseAuth.currentUser!.phoneNumber!;
      });
      _userModel = userModel;

      await _firebaseFirestore.collection("users").doc(_uid).set(userModel.toMap()).then((value) {
        onSuccess();
        _isLoading = false;
        notifyListeners();
      });
    } on FirebaseAuthException catch(e){
      ShowSnackBar(context, e.message.toString());
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<String> storeFileToStorage(String ref, File file) async{
    UploadTask uploadTask = _firebaseStorage.ref().child(ref).putFile(file);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // Storing Data Locally
  Future saveUserDataToSp() async{
    SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("user_model", jsonEncode(userModel.toMap()));
  }

  Future getDataFromFirestore() async{
    await _firebaseFirestore.collection("users").doc(
        _firebaseAuth.currentUser!.uid).get().then
      ((DocumentSnapshot snapshot){
        _userModel = UserModel(
          name: snapshot['name'],
          email: snapshot['email'],
          createdAt: snapshot['createdAt'],
          bio: snapshot['bio'],
          uid: snapshot['uid'],
          profilePic: snapshot['profilePic'],
          phoneNumber: snapshot['phoneNumber'],
        );
        _uid = userModel.uid;
    });
  }
  // get data
  Future getDataFromSP() async{
    SharedPreferences s = await SharedPreferences.getInstance();
    String data = s.getString("user_model") ?? '' ;
    _userModel = UserModel.fromMap(jsonDecode(data));
    _uid= _userModel!.uid;
    notifyListeners();
  }

  //SignOut
  Future userSignOut() async{
    SharedPreferences s = await SharedPreferences.getInstance();
    await _firebaseAuth.signOut();
    _isSignedIn = false;
    notifyListeners();
    s.clear();
  }
}