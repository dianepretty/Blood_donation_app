import 'dart:ffi';

import 'package:blood_system/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui; // Prefix dart:ui with 'ui'


class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child:
          Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  child: Image.asset("assets/images/Blood_illustration.png"),
                  padding: EdgeInsets.all(20),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Text("Give the Gift of Life",  style: TextStyle( color: AppColors.black, fontSize: 30, fontWeight: FontWeight.bold )),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                      child:  Text("Your blood donation can save lives. Join us in making a difference.",
                          textAlign: TextAlign.center,
                          style: TextStyle(  color: AppColors.black, fontSize: 20, fontWeight: FontWeight.normal)) ,
                    ),


                    SizedBox(
                      height: 30,
                    ),

                    ElevatedButton(
                              onPressed: () {

                                print("Register button pressed!");
                                // Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen()));
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:  AppColors.red,
                                  elevation: 0.2,
                                  minimumSize: ui.Size(358, 60),
                          foregroundColor: Colors.white
                        ),
                        child: Text("Register",style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),)),
                    SizedBox(
                      height: 20,
                    ),

                    ElevatedButton(
                        onPressed: () {

                          print("Register button pressed!");
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => RegistrationScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor:  Color(0xFFF8F9FA),
                            minimumSize: ui.Size(358, 60),
                            foregroundColor: AppColors.black,
                          elevation: 0.2,
                        ),
                        child: Text("Login",style: TextStyle(fontSize: 17,fontWeight: FontWeight.w600), )),


                  ],
                )




              ],
            ),
          )

      )

  );
  }
}
