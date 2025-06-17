import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Welcomepage extends StatefulWidget {
  const Welcomepage({super.key});

  @override
  State<Welcomepage> createState() => _WelcomepageState();
}

class _WelcomepageState extends State<Welcomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: Stack(
          children: [
            SizedBox.expand(
              child: Image.asset(
                'assets/images/backgroundpicture.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(
              color: Color(0x90D7263D),

            ),
            Center(
              child:  Icon(
                Icons.bloodtype,
                color: Colors.white,
                size: 120,
              ),
            ),
          ],
        )


    );
  }
}
