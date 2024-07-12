import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/loginorsignup/login.dart';
import 'screens/loading/loadingscreen.dart';
import 'pbsetup/pb.dart';
import 'screens/currentroute.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<bool> checkAuth() async {
    await Future.delayed(const Duration(milliseconds: 100));
    
    final prefs = await SharedPreferences.getInstance();
    final localAuthStatus = prefs.getBool('isLoggedIn') ?? false;

    if (localAuthStatus) {
      return pb.authStore.isValid;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce sample',
      theme: ThemeData(
        textTheme: GoogleFonts.rubikTextTheme(),
      ),
      home: FutureBuilder<bool>(
        future: checkAuth(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Loadingscreen();
          } else {
            if (snapshot.data == true) {
              return const CurrentRoute();
            } else {
              return const Login();
            }
          }
        },
      ),
    );
  }
}
