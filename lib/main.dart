import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'admin/edit_recipe.dart';
import 'login_page.dart';
import 'admin/welcome_admin_page.dart'; // Adjust the import path if necessary
// import 'firebase_options.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFFFEA192),
    ),
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyB_9YAHylbtHmMhWt3IU6lxvKHkT5e-jbw",
      appId: "1:302130084268:android:a75f72e10eb1eeb4b1a209",
      messagingSenderId: "302130084268",
      projectId: "butterupp-d660e",
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(  // Wrap the entire app in MaterialApp
      debugShowCheckedModeBanner: false,  // Optionally hide the debug banner
      // theme: ThemeData(
      //   primarySwatch: Colors.orange, // Set your preferred color theme
      // ),
      home:
      //EditPage(category: '', docID: '', recipeName: '', description: '', ingredients: '', instructions: '', imageUrl: '',),
      LoginPage(),
    );
  }
}

//login comment
// class LoginPage extends StatefulWidget {
//   const LoginPage({super.key});
//
//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }
//
// class _LoginPageState extends State<LoginPage> {
//   int _selectedIconIndex = -1;
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(height: 100.0),
//               const Text(
//                 'BatterUp',
//                 style: TextStyle(
//                   fontFamily: 'Lexend',
//                   fontSize: 50.0,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//               Image.asset(
//                 'images/woodroll.png',
//                 width: double.infinity,
//                 height: 10,
//               ),
//               const SizedBox(height: 40.0),
//               // Username and Password inputs...
//               const SizedBox(height: 40.0),
//               // Username and Password inputs...
//               // Username Label and Input
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                 child: const Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Username',
//                       style: TextStyle(
//                         fontFamily: 'Lexend',
//                         color: Colors.black,
//                         fontSize: 30.0,
//                       ),
//                     ),
//                     SizedBox(height: 10.0),
//                     TextField(
//                       decoration: InputDecoration(
//                         hintText: 'Enter Username',
//                         hintStyle: TextStyle(
//                           fontFamily: 'Lexend',
//                           color: Colors.grey,
//                         ),
//                         border: InputBorder.none,
//                       ),
//                       style: TextStyle(
//                         color: Colors.black,
//                       ),
//                     ),
//                     Divider(
//                       color: Colors.black,
//                       thickness: 3.0,
//                       height: 20,
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 40.0),
//
//               // Password Label and Input
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                 child: const Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       'Password',
//                       style: TextStyle(
//                         fontFamily: 'Lexend',
//                         color: Colors.black87,
//                         fontSize: 30.0,
//                       ),
//                     ),
//                     SizedBox(height: 10.0),
//                     TextField(
//                       obscureText: true,
//                       decoration: InputDecoration(
//                         hintText: 'Enter Password',
//                         hintStyle: TextStyle(
//                           fontFamily: 'Lexend',
//                           color: Colors.grey,
//                         ),
//                         border: InputBorder.none,
//                       ),
//                       style: TextStyle(
//                         color: Colors.black,
//                       ),
//                     ),
//                     Divider(
//                       color: Colors.black,
//                       thickness: 3.0,
//                       height: 20,
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 40.0),
//               // Login Button
//               Center(
//                 child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => const WelcomeAdminPage()),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: const Color(0xFFFEA192),
//                     padding: const EdgeInsets.symmetric(horizontal: 110, vertical: 15),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10.0),
//                     ),
//                     elevation: 5,
//                   ),
//                   child: const Text(
//                     'Login',
//                     style: TextStyle(
//                       fontFamily: 'Lexend',
//                       fontSize: 18.0,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 30.0),
//               // "Don't have an account? Sign up"
//               Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       "Don't have an account? ",
//                       style: TextStyle(
//                         fontFamily: 'Lexend',
//                         fontSize: 18.0,
//                         color: Colors.black87,
//                       ),
//                     ),
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const SignUpPage(),
//                           ),
//                         );
//                       },
//                       child: Text(
//                         'Sign up',
//                         style: TextStyle(
//                           fontFamily: 'Lexend',
//                           fontSize: 18.0,
//                           color: const Color(0xFFFEA192),
//                           decoration: TextDecoration.underline,
//                           decorationColor: Colors.red.shade300,
//                           decorationThickness: 2.0,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBottomNavigationBar(double screenHeight) {
//     return BottomAppBar(
//       color: Colors.white,
//       child: SizedBox(
//         height: screenHeight * 0.1,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             // _buildIconButton('clock.png', 0, const NewPage1()),
//             // _buildIconButton('pencil.png', 1, const NewPage2()),
//             // _buildIconButton('user.png', 2, const NewPage3()),
//             // _buildIconButton('heart.png', 3, const NewPage4()),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildIconButton(String iconPath, int index, Widget nextPage) {
//     return IconButton(
//       icon: Image.asset(
//         _selectedIconIndex == index
//             ? 'images/${iconPath.replaceFirst(".png", "-selected.png")}'
//             : 'images/$iconPath',
//         width: 30,
//       ),
//       onPressed: () {
//         setState(() {
//           _selectedIconIndex = index;
//         });
//         Navigator.push(
//           context,
//           MaterialPageRoute(builder: (context) => nextPage),
//         );
//       },
//     );
//   }
// }

// class NewPage1 extends StatelessWidget {
//   const NewPage1({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('New Page 1')),
//       body: const Center(child: Text('This is New Page 1')),
//     );
//   }
// }
//
// class NewPage2 extends StatelessWidget {
//   const NewPage2({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('New Page 2')),
//       body: const Center(child: Text('This is New Page 2')),
//     );
//   }
// }
//
// class NewPage3 extends StatelessWidget {
//   const NewPage3({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('New Page 3')),
//       body: const Center(child: Text('This is New Page 3')),
//     );
//   }
// }
//
// class NewPage4 extends StatelessWidget {
//   const NewPage4({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('New Page 4')),
//       body: const Center(child: Text('This is New Page 4')),
//     );
//   }
// }
