import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'background_widget.dart';
import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  void registerUser() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    if (passwordController.text != confirmPasswordController.text) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Error'),
          content: Text('Passwords do not match.'),
        ),
      );
      return;
    }

    try {
      // Register the user with Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Get the User UID from Firebase Authentication
      User? user = userCredential.user;

      if (user != null) {
        // Use the User UID as the document ID in Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'username': usernameController.text.trim(),
          'lastName': lastNameController.text.trim(),
          'contactNumber': contactNumberController.text.trim(),
          'email': emailController.text.trim(),
          'timestamp': Timestamp.now(),
        });

        // Navigate to the LoginPage after successful registration
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: Text(e.message ?? 'An unknown error occurred.'),
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
            const home_background(),
            SafeArea(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 70.0),
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
                      const SizedBox(height: 40.0),
                      const Text(
                        'Personal Details',
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      _buildInputField(
                        controller: usernameController,
                        label: 'Username',
                        hintText: 'Enter Username',
                      ),
                      _buildInputField(
                        controller: lastNameController,
                        label: 'Last Name',
                        hintText: 'Enter Last Name',
                      ),
                      _buildInputField(
                        controller: contactNumberController,
                        label: 'Contact Number',
                        hintText: 'Enter Contact Number',
                        keyboardType: TextInputType.phone,
                      ),
                      _buildInputField(
                        controller: emailController,
                        label: 'Email',
                        hintText: 'Enter Email',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      _buildInputField(
                        controller: passwordController,
                        label: 'Password',
                        hintText: 'Enter Password',
                        obscureText: true,
                      ),
                      _buildInputField(
                        controller: confirmPasswordController,
                        label: 'Confirm Password',
                        hintText: 'Re-enter Password',
                        obscureText: true,
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: registerUser,
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
                          'Create Account',
                          style: TextStyle(
                            fontFamily: 'Lexend',
                            fontSize: 18.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an account? ",
                            style: TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 18.0,
                              color: Colors.black87,
                            ),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginPage()),
                            ),
                            child: const Text(
                              'Log In',
                              style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 18.0,
                                color: Color(0xFFFEA192),
                                decoration: TextDecoration.underline,
                                decorationColor: Color(0xFFFEA192),
                                decorationThickness: 2.0,
                              ),
                            ),
                          ),
                        ],
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
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
      child: Column(
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
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(fontFamily: 'Lexend', color: Colors.grey),
              border: const OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }
}
