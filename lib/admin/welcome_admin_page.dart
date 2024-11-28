import 'package:flutter/material.dart';
import '../background_widget.dart';
import 'create_recipe.dart';
import 'home_page_admin.dart'; // Import the background widget

class WelcomeAdminPage extends StatefulWidget {
  const WelcomeAdminPage({super.key});

  @override
  State<WelcomeAdminPage> createState() => _WelcomeAdminPageState();
}

class _WelcomeAdminPageState extends State<WelcomeAdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
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
                              'Welcome, Admin!',
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
                          // Check Recipes Button
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const Homepage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFEA192),
                              padding: const EdgeInsets.symmetric(horizontal: 65, vertical: 15),
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
                          const SizedBox(height: 20.0),

                          //create recipe
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const CreatePage()),
                              );                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFEA192),
                              padding: const EdgeInsets.symmetric(horizontal: 65, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 5,
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 24,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Create Recipes',
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
                        child: Text(
                          'Log out',
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
