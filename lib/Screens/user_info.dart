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
}

Widget textFeld({
  required String hintText,
  required IconData icon,
  required TextInputType inputType,
  required int maxLines,
  required TextEditingController controller,
}) {
  return Padding(
      padding: const EdgeInsets.only(bottom: 10),
  child: TextFormField(),
  );
}