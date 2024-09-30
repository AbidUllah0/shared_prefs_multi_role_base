import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_prefs_multi_role_app/screens/home_screen/home_screen.dart';
import 'package:shared_prefs_multi_role_app/screens/student_screen/studentScreen.dart';
import 'package:shared_prefs_multi_role_app/screens/teacher_screen/teacher_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final ageController = TextEditingController();

  // To hold the selected user type
  String? selectedUserType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Email',
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: 'Password',
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: 'Age',
              ),
            ),
            SizedBox(height: 20),
            // Dropdown Button for user type selection
            DropdownButton<String>(
              value: selectedUserType,
              hint: Text('Select User Type'),
              items:
                  <String>['student', 'teacher', 'admin'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedUserType = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            InkWell(
              onTap: () async {
                SharedPreferences sp = await SharedPreferences.getInstance();
                sp.setString('email', emailController.text.toString());
                sp.setString('age', ageController.text.toString());
                sp.setBool('isLogin', true);
                // sp.setString('userType', 'student');
                sp.setString('userType',
                    selectedUserType ?? 'student'); // Saving userType
                setState(() {});
                if (sp.getString('userType') == 'student') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => StudentScreen()));
                } else if (sp.getString('userType') == 'teacher') {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TeacherScreen()));
                } else {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                }
              },
              child: Container(
                height: 50,
                color: Colors.green,
                width: double.infinity,
                child: Center(
                  child: Text('Sign Up'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
