import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'edit_recipe.dart';
import '../profile.dart';
import 'welcome_admin_page.dart';
import '../background_widget.dart';
import '../firestore.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String _selectedOption = 'Cakes';
  List<bool> _expandedList = [];

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
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.02,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          'BatterUp',
                          style: TextStyle(
                            fontFamily: 'Lexend',
                            fontSize: 35.0,
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
                        const Spacer(),
                        Container(
                          width: screenWidth * 0.35,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEA192),
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: DropdownButtonHideUnderline(
                            child: Center(
                              child: DropdownButton<String>(
                                value: _selectedOption,
                                onChanged: (String? newValue) {
                                  if (newValue != null) {
                                    setState(() {
                                      _selectedOption = newValue;
                                    });
                                  }
                                },
                                dropdownColor: const Color(0xFFFEA192),
                                items: <String>['Cakes', 'Cupcakes', 'Cookies']
                                    .map<DropdownMenuItem<String>>(
                                      (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: const TextStyle(
                                          fontFamily: 'Lexend',
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                                icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: screenHeight * 0.02),

                    StreamBuilder<QuerySnapshot>(
                      stream: FirestoreService().getRecipesStream(_selectedOption),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(child: CircularProgressIndicator());
                        }

                        final documents = snapshot.data!.docs;

                        // Initialize _expandedList only once or when the number of documents changes.
                        if (_expandedList.isEmpty || _expandedList.length != documents.length) {
                          _expandedList = List.filled(documents.length, false);
                        }

                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: documents.length,
                          itemBuilder: (context, index) {
                            var doc = documents[index];
                            String imageUrl = doc['imageUrl'];
                            String recipeName = doc['recipeName'];
                            String description = doc['description'];
                            String ingredients = doc['ingredients'];
                            String instructions = doc['instructions'];

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Column(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    width: screenWidth * 0.9, // 90% of screen width
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(20.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(20),
                                            topRight: Radius.circular(20),
                                          ),
                                          child: Image.network(
                                            imageUrl,
                                            width: screenWidth * 0.9,
                                            height: screenHeight * 0.25,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                recipeName,
                                                style: const TextStyle(
                                                  fontSize: 25,
                                                  fontFamily: 'Lexend',
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              if (_expandedList[index]) ...[
                                                const SizedBox(height: 10),
                                                const Text(
                                                  "Description",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontFamily: 'Lexend',
                                                      color: Color(0xFFFEA192),
                                                      fontWeight: FontWeight.bold),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  description,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: 'Lexend',
                                                      //fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                const Text(
                                                  "Ingredients",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontFamily: 'Lexend',
                                                      color: Color(0xFFFEA192),
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  ingredients,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: 'Lexend',
                                                      //fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                const Text(
                                                  "Instructions",
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      fontFamily: 'Lexend',
                                                      color: Color(0xFFFEA192),
                                                      fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  instructions,
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: 'Lexend',
                                                      //fontWeight: FontWeight.bold
                                                  ),
                                                ),
                                              ],
                                              //option buttons
                                              const SizedBox(height: 15),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  ElevatedButton(
                                                    onPressed: () => _confirmDelete(context, _selectedOption, doc.id), // Call the confirmation function
                                                    style: ElevatedButton.styleFrom(
                                                      backgroundColor: Colors.redAccent,
                                                      elevation: 5,
                                                      shape: RoundedRectangleBorder(
                                                        borderRadius: BorderRadius.circular(8.0),
                                                      ),
                                                    ),
                                                    child: const Text(
                                                      'Delete',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'Lexend',
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),

                                                  Row(
                                                    children: [
                                                      ElevatedButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            _expandedList[index] = !_expandedList[index];
                                                          });
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor: const Color(0xFFFEA192),
                                                          elevation: 5,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(8.0),
                                                          ),
                                                        ),
                                                        child: Text(
                                                          _expandedList[index] ? 'Hide Details' : 'View Recipe',
                                                          style: const TextStyle(
                                                            color: Colors.white,
                                                            fontFamily: 'Lexend',
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(width: 10),

                                                      ElevatedButton(
                                                        onPressed: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder: (context) => EditPage(
                                                                category: _selectedOption,
                                                                docID: doc.id,
                                                                recipeName: recipeName,
                                                                description: description,
                                                                ingredients: ingredients,
                                                                instructions: instructions,
                                                                imageUrl: imageUrl,
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        style: ElevatedButton.styleFrom(
                                                          backgroundColor: const Color(0xFFFEA192),
                                                          elevation: 5,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(8.0),
                                                          ),
                                                        ),
                                                        child: const Text(
                                                          'Edit',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily: 'Lexend',
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ),

                                                    ],
                                                  ),
                                                ],
                                              ),

                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),

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
              IconButton(
                icon: Image.asset('images/clock.png', width: 30),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const WelcomeAdminPage()),
                  );
                },
              ),
              IconButton(
                icon: Image.asset('images/pencil.png', width: 30),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Homepage()),
                  );
                },
              ),
              IconButton(
                icon: Image.asset('images/user.png', width: 30),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Profile()),
                  );
                },
              ),
              IconButton(
                icon: Image.asset('images/heart.png', width: 30),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),

    );
  }
}

void _confirmDelete(BuildContext context, String category, String docID) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(
          'Confirm Delete',
          style: TextStyle(
            fontFamily: 'Lexend',
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text(
          'Are you sure you want to delete this recipe?',
          style: TextStyle(fontFamily: 'Lexend'),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(
              'Cancel',
              style: TextStyle(color: Colors.grey, fontFamily: 'Lexend'),
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
          TextButton(
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.redAccent, fontFamily: 'Lexend'),
            ),
            onPressed: () {
              FirestoreService().deleteRecipe(category, docID).then((_) {
                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Recipe deleted successfully',
                      style: TextStyle(fontFamily: 'Lexend'),
                    ),
                  ),
                );
              }).catchError((error) {
                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Failed to delete: $error',
                      style: const TextStyle(fontFamily: 'Lexend'),
                    ),
                  ),
                );
              });
            },
          ),
        ],
      );
    },
  );
}


