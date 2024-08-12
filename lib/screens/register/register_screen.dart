import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:test_rnb/screens/login/login_screen.dart';
import 'package:test_rnb/services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();

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
            'Register',
            style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _namaController,
              decoration: const InputDecoration(
                labelText: 'Nama',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _passwordController,
              obscureText: _obsecureText,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(
                      _obsecureText ? Icons.visibility : Icons.visibility_off),
                  onPressed: _toggle,
                ),
                labelText: 'Password',
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
                await AuthService().signup(
                    nama: _namaController.text,
                    email: _emailController.text,
                    password: _passwordController.text,
                    context: context);
              },
              child:
                  const Text('Register', style: TextStyle(color: Colors.white)),
            ),
          ),
          RichText(
              text: TextSpan(children: [
            const TextSpan(
              text: 'Sudah punya akun? ',
              style: TextStyle(color: Colors.black),
            ),
            TextSpan(
              text: 'Login disini',
              style: const TextStyle(color: Colors.deepPurple),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
            )
          ])),
        ],
      ),
    );
  }
}
