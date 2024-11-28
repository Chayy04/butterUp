import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore
// import 'FirestoreService.dart'; // Import the FirestoreService
import '../background_widget.dart';
import '../firestore.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  String? selectedCategory = 'Cakes'; // Default selected category
  final TextEditingController recipeNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();
  final TextEditingController instructionsController = TextEditingController();
  final TextEditingController recipeImageController = TextEditingController();

  final FirestoreService firestoreService = FirestoreService(); // Initialize Firestore service

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
                      const SizedBox(height: 10.0),
                      const Text(
                        'Create Recipe',
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20.0),

                      // Category Dropdown
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            DropdownButtonHideUnderline(
                              child: Container(
                                width: 120,
                                height: 50,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFEA192),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Center(
                                  child: DropdownButton<String>(
                                    value: selectedCategory,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        selectedCategory = newValue;
                                      });
                                    },
                                    dropdownColor: const Color(0xFFFEA192),
                                    items: <String>['Cakes', 'Cupcakes', 'Cookies']
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20.0),

                      // TextFields
                      _buildTextField(
                        controller: recipeNameController,
                        label: 'Recipe Name',
                        hintText: 'Enter recipe name',
                      ),
                      const SizedBox(height: 20.0),
                      _buildTextField(
                        controller: descriptionController,
                        label: 'Description',
                        hintText: 'Enter description',
                      ),
                      const SizedBox(height: 20.0),
                      _buildTextField(
                        controller: ingredientsController,
                        label: 'Ingredients',
                        hintText: 'Enter ingredients',
                      ),
                      const SizedBox(height: 20.0),
                      _buildTextField(
                        controller: instructionsController,
                        label: 'Instructions',
                        hintText: 'Enter instructions',
                      ),
                      const SizedBox(height: 20.0),
                      _buildTextField(
                        controller: recipeImageController,
                        label: 'Recipe Image',

                        hintText: 'Enter image URL',
                      ),
                      const SizedBox(height: 40.0),
                      // Buttons Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context); // Go back to the previous page
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 5,
                            ),
                            child: const Text(
                              'Cancel',
                              style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const SizedBox(width: 20.0),

                          // Save Button
                          ElevatedButton(
                            onPressed: _saveRecipe, // Call save function
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFEA192),
                              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              elevation: 5,
                            ),
                            child: const Text(
                              'Save',
                              style: TextStyle(
                                fontFamily: 'Lexend',
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30.0),
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

  // Helper function to build text fields
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontFamily: 'Lexend',
              color: Colors.black,
              fontSize: 18.0,
            ),
          ),
          const SizedBox(height: 10.0),
          TextField(
            controller: controller,
            maxLines: null,
            minLines: 1,
            keyboardType: TextInputType.multiline,
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
      ),
    );
  }

  // Function to save the recipe to Firestore
  Future<void> _saveRecipe() async {
    if (selectedCategory != null &&
        recipeNameController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        ingredientsController.text.isNotEmpty &&
        instructionsController.text.isNotEmpty &&
        recipeImageController.text.isNotEmpty) {
      await firestoreService.addRecipe(
        selectedCategory!,
        recipeNameController.text,
        descriptionController.text,
        ingredientsController.text,
        instructionsController.text,
        recipeImageController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recipe added successfully!')),
      );
      Navigator.pop(context); // Go back after saving
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all the fields.')),
      );
    }
  }
}
