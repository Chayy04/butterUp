import 'package:flutter/material.dart';
import '../firestore.dart';
import '../background_widget.dart';

class EditPage extends StatefulWidget {
  final String category;
  final String docID;
  final String recipeName;
  final String description;
  final String ingredients;
  final String instructions;
  final String imageUrl;

  const EditPage({
    super.key,
    required this.category,
    required this.docID,
    required this.recipeName,
    required this.description,
    required this.ingredients,
    required this.instructions,
    required this.imageUrl,
  });

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  String? selectedCategory;
  final TextEditingController recipeNameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController ingredientsController = TextEditingController();
  final TextEditingController instructionsController = TextEditingController();
  final TextEditingController recipeImageController = TextEditingController();

  final FirestoreService firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    selectedCategory = widget.category;
    recipeNameController.text = widget.recipeName;
    descriptionController.text = widget.description;
    ingredientsController.text = widget.ingredients;
    instructionsController.text = widget.instructions;
    recipeImageController.text = widget.imageUrl;
  }

  Future<void> _updateRecipe() async {
    if (selectedCategory != null &&
        recipeNameController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty &&
        ingredientsController.text.isNotEmpty &&
        instructionsController.text.isNotEmpty &&
        recipeImageController.text.isNotEmpty) {
      await firestoreService.updateRecipe(
        selectedCategory!,
        widget.docID,
        recipeNameController.text,
        descriptionController.text,
        ingredientsController.text,
        instructionsController.text,
        recipeImageController.text,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recipe updated successfully!')),
      );
      Navigator.pop(context); // Go back after saving
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all the fields.')),
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
                      const SizedBox(height: 10.0),
                      const Text(
                        'Edit Recipe',
                        style: TextStyle(
                          fontFamily: 'Lexend',
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20.0),

                      // Display category as non-editable text
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              width: 120,
                              height: 50,
                              decoration: BoxDecoration(
                                color: const Color(0xFFFEA192),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Center(
                                child: Text(
                                  widget.category,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Lexend',
                                    fontSize: 18,
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

                      // Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              Navigator.pop(context); // Go back
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
                          ElevatedButton(
                            onPressed: _updateRecipe, // Call update function
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
}
