import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_book_local_database/models/recipe_model.dart';
import 'package:recipe_book_local_database/providers/recipe_provider.dart';
import 'package:provider/provider.dart';

import 'edit_data_screen.dart';

class ShowRecipeScreen extends StatelessWidget {
  final RecipeModel recipeModel;

  const ShowRecipeScreen({super.key, required this.recipeModel});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeClass>(
        builder: ((context, provider, child) => Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.deepPurple[900],
                iconTheme: const IconThemeData(
                  color:
                      Colors.white, // Change the color of the drawer icon here
                ),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(20), // Circular border radius
                  ),
                ),
                actions: [
                  InkWell(
                      onTap: () {
                        provider.nameController.text = recipeModel.name;
                        provider.preperationTimeController.text =
                            recipeModel.preperationTime.toString();
                        provider.ingredientsController.text =
                            recipeModel.ingredients;
                        provider.instructionsController.text =
                            recipeModel.instructions;
                        provider.image = recipeModel.image;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) => EditRecipeScreen(
                                    recipeModel: recipeModel))));
                      },
                      child: const Icon(
                        Icons.edit,
                      )),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                      onTap: () {
                        provider.deleteRecipe(recipeModel);
                        Navigator.pop(context);
                        // ),
                      },
                      child: const Icon(Icons.delete)),
                ],
              ),
              body: SingleChildScrollView(
                child: Column(children: [
                  Container(
                    margin: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: !Provider.of<RecipeClass>(context).isDark
                            ? Colors.deepPurple[900]
                            : null,
                        border: Border.all(
                          color: Colors.white,
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(5)),
                    height: 170,
                    //width: double.infinity,
                    child: recipeModel.image == null
                        ? const Text('')
                        : Image.file(
                            recipeModel.image!,
                          ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: Text(
                      recipeModel.name,
                      style: GoogleFonts.poppins(
                        //textStyle: Theme.of(context).textTheme.displayLarge,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple[900],
                        //fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: !Provider.of<RecipeClass>(context).isDark
                            ? Colors.deepPurple[900]
                            : null,
                        border: Border.all(
                          color: Colors.white,
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        // const Text(
                        //   '',
                        //   style: TextStyle(
                        //       fontSize: 16, fontWeight: FontWeight.bold),
                        // ),
                        // const SizedBox(
                        //   width: 10,
                        // ),
                        Text(
                          '${recipeModel.preperationTime}',
                          style: GoogleFonts.poppins(
                            //textStyle: Theme.of(context).textTheme.displayLarge,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            //fontStyle: FontStyle.italic,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: !Provider.of<RecipeClass>(context).isDark
                            ? Colors.deepPurple[900]
                            : null,
                        border: Border.all(
                          color: Colors.white,
                          width: 5,
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const Text(
                        //   '',
                        //   style: TextStyle(
                        //       fontSize: 16, fontWeight: FontWeight.bold),
                        // ),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        Text(
                          recipeModel.ingredients,
                          style: GoogleFonts.poppins(
                            //textStyle: Theme.of(context).textTheme.displayLarge,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            //fontStyle: FontStyle.italic,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: !Provider.of<RecipeClass>(context).isDark
                            ? Colors.deepPurple[900]
                            : null,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                          width: 5,
                        )),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // const Text(
                        //   'Instructions',
                        //   style: TextStyle(
                        //       fontSize: 16, fontWeight: FontWeight.bold),
                        // const SizedBox(
                        //   height: 20,
                        // ),
                        Text(
                          recipeModel.instructions,
                          style: GoogleFonts.poppins(
                            //textStyle: Theme.of(context).textTheme.displayLarge,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            //fontStyle: FontStyle.italic,
                          ),
                          //style: const TextStyle(fontSize: 26),
                        )
                      ],
                    ),
                  ),
                ]),
              ),
            )));
  }
}
