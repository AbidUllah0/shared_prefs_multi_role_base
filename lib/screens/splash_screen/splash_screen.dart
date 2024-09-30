import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_prefs_multi_role_app/screens/admin_screen/admin_screen.dart';
import 'package:shared_prefs_multi_role_app/screens/home_screen/home_screen.dart';
import 'package:shared_prefs_multi_role_app/screens/login_screen/login_screen.dart';
import 'package:shared_prefs_multi_role_app/screens/student_screen/studentScreen.dart';
import 'package:shared_prefs_multi_role_app/screens/teacher_screen/teacher_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    isLogin();
    super.initState();
  }

  void isLogin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    bool isLogin = sp.getBool('isLogin') ?? false;
    String userType = sp.getString('userType') ?? '';
    if (isLogin) {
      if (userType == 'student') {
        Timer(Duration(seconds: 3), () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => StudentScreen()));
        });
      } else if (userType == 'teacher') {
        Timer(Duration(seconds: 3), () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => TeacherScreen()));
        });
      } else if (userType == 'admin') {
        Timer(Duration(seconds: 3), () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AdminScreen()));
        });
      } else {
        Timer(Duration(seconds: 3), () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => HomeScreen()));
        });
      }
    } else {
      Timer(Duration(seconds: 3), () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Image(
      height: double.infinity,
      fit: BoxFit.cover,
      image: NetworkImage(
          'https://images.pexels.com/photos/28497015/pexels-photo-28497015/free-photo-of-fashionable-woman-in-stylish-skirt-outdoors.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
    ));
  }
}
