import 'package:grad_chain/resources/auth_methods.dart';
import 'package:grad_chain/responsive/university/uni_mobile_screen.dart';
import 'package:grad_chain/responsive/university/uni_web_screen.dart';
import 'package:grad_chain/screens/index/landing_screen.dart';
import 'package:grad_chain/screens/index/signup_screen.dart';
import 'package:grad_chain/utils/colors.dart';
import 'package:grad_chain/utils/utils.dart';
import 'package:grad_chain/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../responsive/student/mobile_screen_layout.dart';
import '../../responsive/index/responsive_layout_screen.dart';
import '../../responsive/student/web_screen_layout.dart';

class StudentLoginScreen extends StatefulWidget {
  const StudentLoginScreen({super.key});

  @override
  State<StudentLoginScreen> createState() => _StudentLoginScreenState();
}

class _StudentLoginScreenState extends State<StudentLoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await AuthMethods().loginUser(
      email: _emailController.text,
      password: _passwordController.text,
    );

    if (res == "success") {
      var push = Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
            uniMobileScreenLayout: UniMobileScreen(),
            uniWebScreenLayout: UniWebScreen(),
          ),
        ),
      );
    } else {
      showSnackBar(res, context);
    }

    setState(() {
      _isLoading = false;
    });
  }

  void NavigateToLandingScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LandingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Container(),
              flex: 2,
            ),
            // svg image (we use a package called flutter_svg to show svg images)
            Image.asset(
              'assets/images/gradchain_logo.png',
              height: 250,
              width: 450,
              fit: BoxFit.fitWidth,
            ),

            const SizedBox(height: 64),
            // text input for email
            TextFieldInput(
              hintText: 'Enter your email',
              textInputType: TextInputType.emailAddress,
              textEditingController: _emailController,
            ),
            const SizedBox(
              height: 24,
            ),
            // text input for password
            TextFieldInput(
              hintText: 'Enter your password',
              textInputType: TextInputType.text,
              textEditingController: _passwordController,
              isPass: true,
            ),
            const SizedBox(
              height: 24,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: Colors.grey[400],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text(
                      'Are you new here? Create an account below.',
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: NavigateToLandingScreen,
                        child: Container(
                          //padding: const EdgeInsets.symmetric(
                          //  vertical: 8,
                          //  horizontal: 4,
                          //),
                          child: const Text(
                            "Not a Student",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Divider(
                thickness: 0.5,
                color: Colors.grey[400],
              ),
            ),
            /*Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: const Text("Are you new here?"),
                  ),
            */
            // Sign Up text at the bottom of the screen

            const SizedBox(
              height: 24,
            ),

            // button for login
            InkWell(
              onTap: loginUser,
              child: Container(
                child: _isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : const Text('Log in',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        )),
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4),
                    ),
                  ),
                  color: Colors.black,
                ),
              ),
            ),

            const SizedBox(
              height: 12,
            ),
            Flexible(
              child: Container(),
              flex: 2,
            ),
            // transitioning to sign up
          ],
        ),
      )),
    );
  }
}
