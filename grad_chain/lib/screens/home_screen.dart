import 'package:flutter/material.dart';
import 'package:grad_chain/screens/login_screen.dart';
import 'package:grad_chain/screens/signup_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 23, 67, 24),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          AspectRatio(
            aspectRatio: 16 / 3,
            child: Container(
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                //Grad Chain
                Icon(
                  Icons.circle_sharp,
                  color: Colors.green[200],
                ),
                SizedBox(
                  width: 3,
                ),
                Text(
                  'GradChain',
                  style: TextStyle(
                    fontSize: 70,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
            ),
          ),
          SizedBox(height: 5),
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
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text('Log In'),
                ),
                SizedBox(width: 30),
                //sign up
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignupScreen()),
                    );
                  },
                  child: Text('Sign Up'),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
