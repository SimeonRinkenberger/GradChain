import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:grad_chain/providers/user_provider.dart';
import 'package:grad_chain/responsive/mobile_screen_layout.dart';
import 'package:grad_chain/responsive/responsive_layout_screen.dart';
import 'package:grad_chain/responsive/web_screen_layout.dart';
import 'package:grad_chain/screens/login_screen.dart';
import 'package:grad_chain/screens/signup_screen.dart';
import 'package:grad_chain/utils/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDX4nN-wj3H8QJTR1PzcNBHa1DOw0S-7tQ",
        appId: "1:958045716239:web:dc29447388ce5752ba887a",
        messagingSenderId: "958045716239",
        projectId: "instagram-clone-d1b79",
        storageBucket: "instagram-clone-d1b79.appspot.com",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // First we wrapped the Material App with Multiprovider provided by Flutter
    return MultiProvider(
      // We use this setup because as the app gets bigger there will be more providers
      providers: [
        ChangeNotifierProvider(
          // this is provided by the provider package
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram clone',
        theme: ThemeData.light()
            .copyWith(scaffoldBackgroundColor: mobileBackgroundColor),
        // const because we are not going to have dynamic values passed to the constructor

        home: StreamBuilder(
          // This right here is used to check if the user was already signed in
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // snapshot comes from the stream, context comes from the widget build
            if (snapshot.connectionState == ConnectionState.active) {
              // Active means that a connection with FirebaseAuth has been made
              if (snapshot.hasData) {
                return const ResponsiveLayout(
                  mobileScreenLayout: MobileScreenLayout(),
                  webScreenLayout: WebScreenLayout(),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('${snapshot.error}'),
                );
              }
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              );
            }

            return const LoginScreen();
          },
        ),
      ),
    );
  }
}
// test