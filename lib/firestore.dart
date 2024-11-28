import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // Reference to collections for different recipe categories
  final CollectionReference cakes =
  FirebaseFirestore.instance.collection('Cakes');
  final CollectionReference cupcakes =
  FirebaseFirestore.instance.collection('Cupcakes');
  final CollectionReference cookies =
  FirebaseFirestore.instance.collection('Cookies');

  // Create operation: Adds a new recipe to the appropriate collection based on the category
  Future<void> addRecipe(String category, String recipeName, String description, String ingredients, String instructions, String imageUrl) {
    // Select the appropriate collection based on category
    CollectionReference selectedCollection = _getCategoryCollection(category);

    return selectedCollection.add({
      'recipeName': recipeName,
      'description': description,
      'ingredients': ingredients,
      'instructions': instructions,
      'imageUrl': imageUrl,
      'timestamp': Timestamp.now(),
    });
  }

  // Read operation: Stream to get the recipes from a specific category
  Stream<QuerySnapshot> getRecipesStream(String category) {
    // Select the appropriate collection based on category
    CollectionReference selectedCollection = _getCategoryCollection(category);

    return selectedCollection.orderBy('timestamp', descending: true).snapshots();
  }

  // Update operation: Updates a recipe in the appropriate category collection
  Future<void> updateRecipe(String category, String docID, String recipeName, String description, String ingredients, String instructions, String imageUrl) {
    // Select the appropriate collection based on category
    CollectionReference selectedCollection = _getCategoryCollection(category);

    return selectedCollection.doc(docID).update({
      'recipeName': recipeName,
      'description': description,
      'ingredients': ingredients,
      'instructions': instructions,
      'imageUrl': imageUrl,
      'timestamp': Timestamp.now(),
    });
  }

  // Delete operation: Deletes a recipe from the appropriate category collection
  Future<void> deleteRecipe(String category, String docID) {
    // Select the appropriate collection based on category
    CollectionReference selectedCollection = _getCategoryCollection(category);

    return selectedCollection.doc(docID).delete();
  }

  // Helper function to get the correct collection based on the category
  CollectionReference _getCategoryCollection(String category) {
    switch (category) {
      case 'Cakes':
        return cakes;
      case 'Cupcakes':
        return cupcakes;
      case 'Cookies':
        return cookies;
      default:
        throw Exception("Invalid category");
    }
  }
}
