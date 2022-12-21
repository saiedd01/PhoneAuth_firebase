import 'package:flutter/material.dart';
import 'package:phoneauth/Provider/auth_provider.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final ap= Provider.of<AuthProvider>(context , listen: false);
    return Scaffold(
      appBar: AppBar(
      backgroundColor: Colors.purple,
      title: const Text("FlutterPhone Auth"),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.exit_to_app),
        ),
      ],
    ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                backgroundColor: Colors.purple,
                backgroundImage: NetworkImage(ap.userModel.profilePic),
                radius: 50,
              ),
              SizedBox(height: 20,),
              Text(ap.userModel.name),
              Text(ap.userModel.phoneNumber),
              Text(ap.userModel.bio),
              Text(ap.userModel.email),
            ]
        ),
      ),
    );
  }
}
