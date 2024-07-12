import 'package:ecommerce_sample/screens/currentroute.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../pbsetup/pb.dart';


class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  Future<void> _signup() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final body = <String, dynamic>{
        'name': _nameController.text,
        'email': _emailController.text,
        'password': _passwordController.text,
        "passwordConfirm": _passwordController.text,
      };

      final record = await pb.collection("users").create(body: body);
      print("Succeeded in creating user");

      // Automatically log in the user after successful signup
      final authData = await pb.collection("users").authWithPassword(
        _emailController.text,
        _passwordController.text,
      );

      final prefs = await SharedPreferences.getInstance();
      final check = await prefs.setBool('isLoggedIn', true);

      
      
      if(check){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => CurrentRoute()));
      }

    } catch (e) {
      print("Error in creating user: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup failed: ${e.toString()}')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          const Align(
            alignment: Alignment(0, -0.77),
            child: Text(
              "Sign Up",
              style: TextStyle(
                color: Color(0xFF222222),
                fontWeight: FontWeight.w900,
                fontSize: 33
              ),
            ),
          ),
          const Align(
            alignment: Alignment(0, -0.6),
            child: Text(
              "Buy the best & the healthiest plants",
              style: TextStyle(
                color: Color(0xFF868686),
                fontSize: 15
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 200, left: 40),
            child: Column(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: "Password",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(7.0),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isLoading ? null : _signup,
                  child: _isLoading
                    ? CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Sign up",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500
                        ),
                      ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                    ),
                    minimumSize: Size(MediaQuery.of(context).size.width * 0.8, 50)
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
