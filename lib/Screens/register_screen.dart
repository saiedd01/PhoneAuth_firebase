import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneController = TextEditingController();

    Country selectCountry = Country(
        phoneCode: "+20",
        countryCode: "EG",
        e164Sc: 0,
        geographic: true,
        level: 1,
        name: "Egypt",
        example: "Egypt",
        displayName: "Egypt",
        displayNameNoCountryCode: "EG",
        e164Key: "",
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 25 , horizontal: 35),
            child: Column(
                children:[
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
                      color: Colors.black38,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: phoneController,
                    cursorColor: Colors.purple,
                    decoration: InputDecoration(
                      hintText: "Enter phone number",
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.black12),
                      ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.black12),
                        ),
                        prefixIcon:Container(
                          padding: EdgeInsets.all(8),
                          child: InkWell(
                            onTap: (){},
                            child: Text(
                              "${selectCountry.flagEmoji} ${selectCountry.phoneCode}",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                    )
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
