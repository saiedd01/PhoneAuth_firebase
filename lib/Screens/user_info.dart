import 'dart:io';

import 'package:flutter/material.dart';
import 'package:phoneauth/Model/user_model.dart';
import 'package:phoneauth/Provider/auth_provider.dart';
import 'package:phoneauth/Screens/home_screen.dart';
import 'package:phoneauth/Widgets/coustom_button.dart';
import 'package:provider/provider.dart';
import 'package:phoneauth/Utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({Key? key}) : super(key: key);

  @override
  State<UserInformation> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInformation> {
  File? image;
  final nameController =  TextEditingController();
  final emailController =  TextEditingController();
  final bioController =  TextEditingController();

  @override
  void dispose(){
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    bioController.dispose();

  }
  // for selecting image
  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = Provider.of<AuthProvider>(context , listen: true).isLoading;
    return Scaffold(
      body: SafeArea(
        child: isLoading== true
            ? const Center(child: CircularProgressIndicator(
            color: Colors.purple,
          ),
        ):
        SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          child: Center(
            child: Column(
              children: [
                InkWell(
                  onTap: ()=> selectImage(),
                  child: image == null ?
                  const CircleAvatar(
                    backgroundColor: Colors.purple,
                    radius: 50,
                    child: Icon(
                      Icons.account_circle,
                      size: 50,
                      color: Colors.white,
                    ),
                  )
                      :CircleAvatar(
                    backgroundImage: FileImage(image!),
                    radius: 50,
                  )
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                      children: [
                        // name
                        textFeld(
                          hintText: "Saied Ahmed",
                          icon: Icons.account_circle,
                          inputType: TextInputType.name,
                          maxLines: 1,
                          controller: nameController,
                        ),
                        // email
                        textFeld(
                          hintText: "Abc@ex.com",
                          icon: Icons.email,
                          inputType: TextInputType.emailAddress,
                          maxLines: 1,
                          controller: emailController,
                        ),
                        // bio
                        textFeld(
                          hintText: "enter your bio",
                          icon: Icons.edit,
                          inputType: TextInputType.name,
                          maxLines: 3,
                          controller: bioController,
                        ),
                        SizedBox(height: 20),
                        SizedBox(
                          height: 50,
                          width: MediaQuery.of(context).size.width * 0.90,
                          child: CustomButton(
                            text: "Continue",
                            onPressed: () => storeData(),
                          ),
                        ),
                      ]
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  // textField
  Widget textFeld({
    required String hintText,
    required IconData icon,
    required TextInputType inputType,
    required int maxLines,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        cursorColor: Colors.purple,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.purple,
            ),
            child: Icon(
              icon,
              size: 20,
              color: Colors.white,
            ),
          ),
          enabledBorder:  OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          hintText: hintText,
          alignLabelWithHint: true,
          border: InputBorder.none,
          fillColor: Colors.purple.shade50,
          filled: true,
        ),
      ),
    );
  }

  //store data
  void storeData() async {
    final pre = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      bio: bioController.text.trim(),
      profilePic: "",
      createdAt: "",
      phoneNumber: "",
      uid: "",
    );
    if(image != null){
      pre.saveUserDataToFirebase(context: context,
          userModel: userModel,
          profilePic: image!,
          onSuccess:()
          {
            pre.saveUserDataToSp().then((value) =>
            pre.setSignIn().then((value) =>
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (context) => Home(),),
                        (route) => false),),
            );
          },
      );
    }
    else{
      ShowSnackBar(context, "Please upload your profile photo");
    }
  }

}


