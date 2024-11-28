import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'admin/welcome_admin_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void loginUser() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (context.mounted) {
        showDialog(
          context: context,
          builder: (context) => const AlertDialog(
            title: Text('Login Successful!'),
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const WelcomeAdminPage()),
        );
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'images/bg.png',
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 100),
                       Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'BatterUp',
                              style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 50.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            Image.asset(
                              'images/woodroll.png', // Path to your image
                              width: double.infinity, // Makes the image take up the full width
                              height: 10, // Adjust height based on your layout
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40.0),
                      _buildInputField(
                        controller: emailController,
                        label: 'Email',
                        hintText: 'Enter Email',
                      ),
                      const SizedBox(height: 20.0),
                      _buildInputField(
                        controller: passwordController,
                        label: 'Password',
                        hintText: 'Enter Password',
                        obscureText: true,
                      ),
                      const SizedBox(height: 40.0),
                      Center(
                        child: ElevatedButton(
                          onPressed: loginUser,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFEA192),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 110, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                          ),
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 18.0,
                                color: Colors.black87,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const SignUpPage(),
                                  ),
                                );
                              },
                              child: Text(
                                'Sign up',
                                style: TextStyle(
                                  fontFamily: 'Lexend',
                                  fontSize: 18.0,
                                  color: const Color(0xFFFEA192),
                                  decoration: TextDecoration.underline,
                                  decorationColor: Colors.red.shade300,
                                  decorationThickness: 2.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    bool obscureText = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Lexend',
            color: Colors.black,
            fontSize: 30.0,
          ),
        ),
        const SizedBox(height: 10.0),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(
              fontFamily: 'Lexend',
              color: Colors.grey,
            ),
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}
