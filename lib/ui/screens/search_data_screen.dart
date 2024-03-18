import 'package:flutter/material.dart';
import 'package:recipe_book_local_database/models/recipe_model.dart';
import 'package:recipe_book_local_database/ui/widgets/container_widget.dart';

// ignore: must_be_immutable
class SearchRecipeScreen extends StatefulWidget {
  final List<RecipeModel> recipes;
  List<RecipeModel> filteredRecipes = [];

  SearchRecipeScreen({super.key, required this.recipes}) {
    filteredRecipes = recipes;
  }

  @override
  State<SearchRecipeScreen> createState() => _SearchRecipeScreenState();
}

class _SearchRecipeScreenState extends State<SearchRecipeScreen> {
  void filterRecipes(value) {
    setState(() {
      widget.filteredRecipes = widget.recipes
          .where((recipe) =>
              recipe.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.deepPurple[900],
        iconTheme: const IconThemeData(
          color: Colors.white, // Change the color of the drawer icon here
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20), // Circular border radius
          ),
        ),
        title: TextField(
          onChanged: (value) {
            filterRecipes(value);
          },
          style: const TextStyle(
            color: Colors.white,
          ),
          decoration: const InputDecoration(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            hintText: "Search",
            hintStyle: TextStyle(color: Colors.white),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () {
              setState(() {
                Navigator.pop(context);
              });
            },
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: widget.filteredRecipes.isNotEmpty
            ? ListView.builder(
                itemCount: widget.filteredRecipes.length,
                itemBuilder: (BuildContext context, int index) {
                  return RecipeWidget(widget.filteredRecipes[index]);
                })
            : Center(
                child: Icon(
                  Icons.error,
                  color: Colors.deepPurple[900],
                  size: 200,
                ),
              ),
      ),
    );
  }
}
