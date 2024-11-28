import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'background_widget.dart';
import 'home_background.dart';
import 'admin/welcome_admin_page.dart';
import 'admin/home_page_admin.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  late User _user;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      _user = FirebaseAuth.instance.currentUser!;
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('users')
          .doc(_user.uid)
          .get();

      if (userData.exists) {
        setState(() {
          _usernameController.text = userData['username'];
          _lastNameController.text = userData['lastName'];
          _contactController.text = userData['contactNumber'];
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<void> _saveProfile() async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(_user.uid).update({
        'username': _usernameController.text.trim(),
        'lastName': _lastNameController.text.trim(),
        'contactNumber': _contactController.text.trim(),
      });
      setState(() {
        _isEditing = false;
      });
    } catch (e) {
      print("Error saving profile: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          const home_background(),
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Row with Profile text and dot
                    Row(
                      children: [
                        const Text(
                          'Profile',
                          style: TextStyle(
                            fontFamily: 'Lexend',
                            fontSize: 40.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Image.asset(
                          'images/dot.png',
                          width: screenWidth * 0.02,
                          height: screenWidth * 0.02,
                        ),
                      ],
                    ),
                    const SizedBox(height: 15.0),

                    // Avatar and user info stacked vertically
                    Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 60.0,
                            backgroundImage: const AssetImage('images/avatar.png'),
                            backgroundColor: Colors.grey.shade300,
                          ),
                          const SizedBox(height: 10.0),
                          Text(
                            '${_usernameController.text} ${_lastNameController.text}',
                            style: const TextStyle(
                              fontFamily: 'Lexend',
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 5.0),

                        ],
                      ),
                    ),

                    const SizedBox(height: 20.0),
                    _buildTextField('Username', _usernameController),
                    _buildTextField('Last Name', _lastNameController),
                    _buildTextField('Contact Number', _contactController),
                    const SizedBox(height: 30.0),
                    _buildButtonSection(),
                    const SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: SizedBox(
          height: screenHeight * 0.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(icon: Image.asset('images/clock.png', width: 30), onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const WelcomeAdminPage()),
                );
              }),
              IconButton(
                icon: Image.asset('images/pencilunshade.png', width: 30),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Homepage()),
                  );
                },
              ),
              IconButton(
                icon: Image.asset('images/usershade.png', width: 30),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Profile()),
                  );
                },
              ),
              IconButton(icon: Image.asset('images/heart.png', width: 30), onPressed: () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16.0,
              fontFamily: 'Lexend',
              fontWeight: FontWeight.w500,
              color: Color(0xFF303032),
            ),
          ),
          TextField(
            controller: controller,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
            ),
            enabled: _isEditing,
          ),
        ],
      ),
    );
  }

  Widget _buildButtonSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: _isEditing
          ? Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ElevatedButton(
            onPressed: () {
              setState(() => _isEditing = false);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFEA192),
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _saveProfile,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFEA192),
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text(
              'Save Changes',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      )
          : Row(
        children: [
          const Spacer(), // Pushes the button to the right
          ElevatedButton(
            onPressed: () {
              setState(() => _isEditing = true);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFEA192),
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text(
              'Edit Profile',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Lexend',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
