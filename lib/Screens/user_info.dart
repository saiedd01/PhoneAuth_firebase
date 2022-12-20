import 'package:flutter/material.dart';


class UserInformation extends StatefulWidget {
  const UserInformation({Key? key}) : super(key: key);

  @override
  State<UserInformation> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInformation> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
          child: Center(
            child: Column(
              children: [
                InkWell(
                  onTap: (){},
                  child: Image == null ?
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
