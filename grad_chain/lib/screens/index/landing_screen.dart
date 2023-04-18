import 'package:flutter/material.dart';
import 'package:grad_chain/screens/index/home_screen.dart';
import 'package:grad_chain/screens/index/login_screen.dart';
import 'package:grad_chain/screens/index/signup_screen.dart';
import 'package:grad_chain/screens/index/verification_screen.dart';
import 'package:grad_chain/screens/student/student_login_screen.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  State<LandingScreen> createState() => _LandingScreen();
}

class _LandingScreen extends State<LandingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 219, 222, 219),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: 16 / 3,
            child: Container(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                //Grad Chain
                Image.asset(
                  'assets/images/gradchain_logo.png',
                  height: 250,
                  width: 450,
                  fit: BoxFit.fitWidth,
                ),
              ]),
            ),
          ),
          SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            //Block Chain For Deplomas
            Text(
              'Blockchain For Diplomas',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
          ]),
          SizedBox(height: 10),
          //Know qualifications with 100% confidence
          Text(
            'Know qualifications with 100% confidence',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w100),
          ),
          SizedBox(height: 10),
          //add file
          SizedBox(height: 10),
          Container(
            child: AspectRatio(
              aspectRatio: 16 / 3,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                //login
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  },
                  child: Text('University'),
                ),
                SizedBox(width: 30),
                //sign up
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => StudentLoginScreen()),
                    );
                  },
                  child: Text('Student'),
                ),
                SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VerifyScreen()),
                    );
                  },
                  child: Text('Verify'),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
