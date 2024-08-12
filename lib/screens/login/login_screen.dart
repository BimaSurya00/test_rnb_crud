import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:test_rnb/screens/register/register_screen.dart';
import 'package:test_rnb/services/auth_service.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  bool _obsecureText = true;

  void _toggle() {
    setState(() {
      _obsecureText = !_obsecureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Login',
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: TextField(
              controller: _passwordController,
              obscureText: _obsecureText,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                      _obsecureText ? Icons.visibility : Icons.visibility_off),
                  onPressed: _toggle,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.deepPurple),
                fixedSize: MaterialStateProperty.all(const Size(200, 50)),
              ),
              onPressed: () async {
                await AuthService().signin(
                    email: _emailController.text,
                    password: _passwordController.text,
                    context: context);
              },
              child: const Text('Login', style: TextStyle(color: Colors.white)),
            ),
          ),
          RichText(
              text: TextSpan(children: [
            TextSpan(
              text: 'Belum punya akun? ',
              style: const TextStyle(color: Colors.black),
            ),
            TextSpan(
              text: 'Daftar disini',
              style: const TextStyle(color: Colors.deepPurple),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
            )
          ])),
        ],
      ),
    );
  }
}
