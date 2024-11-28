import 'package:flutter/material.dart';
import 'background_widget.dart'; // Import the background widget

class WelcomeUserPage extends StatefulWidget {
  const WelcomeUserPage({super.key});

  @override
  State<WelcomeUserPage> createState() => _WelcomeUserPageState();
}

class _WelcomeUserPageState extends State<WelcomeUserPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Reuse the BackgroundWidget from the widget folder
          const home_background(),
          // Your SignUpPage content
          SafeArea(
            child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Project Name at the top
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
                    const SizedBox(height: 20.0),

                    // Welcome message and Image
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'Welcome, User!',
                              style: TextStyle(
                                fontFamily: 'Lexend',
                                color: Colors.black,
                                fontSize: 35.0,
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            Image.asset(
                              'images/pastry_chef.png', // Path to your image
                              fit: BoxFit.contain,
                              width: double.infinity,
                              height: 300,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30.0),

                    // Check Recipes Button
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              debugPrint('Check Recipes Button Pressed!');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFEA192),                              padding: const EdgeInsets.symmetric(horizontal: 77, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 5,
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  'images/cakeicon.png', // Custom icon for Check Recipes
                                  width:23,
                                  height: 23,
                                  //color: Colors.white,
                                  //colorBlendMode: BlendMode.srcIn,
                                ),
                                const SizedBox(width: 15),
                                const Text(
                                  'Check Recipes',
                                  style: TextStyle(
                                    fontFamily: 'Lexend',
                                    fontSize: 18.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20.0),

                    // Logout Gesture
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          debugPrint('Logout tapped!');
                        },
                        child: const Text(
                          'Log out',
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
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
