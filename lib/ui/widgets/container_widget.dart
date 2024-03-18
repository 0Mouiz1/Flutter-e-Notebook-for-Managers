import 'package:flutter/material.dart';
import 'package:recipe_book_local_database/providers/recipe_provider.dart';
import 'package:recipe_book_local_database/ui/screens/show_data_screen.dart';
import 'package:provider/provider.dart';

import '../../models/recipe_model.dart';

class RecipeWidget extends StatelessWidget {
  final RecipeModel recipeModel;

  const RecipeWidget(this.recipeModel, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) =>
                    ShowRecipeScreen(recipeModel: recipeModel))));
      }),
      child: Container(
        decoration: BoxDecoration(
            color:
                !Provider.of<RecipeClass>(context).isDark ? Colors.deepPurple[900] : null,
            borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.all(5),
        child: ListTile(
          tileColor:
              !Provider.of<RecipeClass>(context).isDark ? Colors.white : null,
          leading: recipeModel.image == null
              ? Container(
                  decoration: BoxDecoration(
                      color: !Provider.of<RecipeClass>(context).isDark
                          ? Colors.green
                          : null,
                      borderRadius: BorderRadius.circular(8)),
                  height: double.infinity,
                  width: 70,
                  child: const Center(
                    child: Text(''),
                  ),
                )
              : Image.file(
                  recipeModel.image!,
                  width: 70,
                  height: double.infinity,
                ),
          title: Text(
            recipeModel.name,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            '${recipeModel.preperationTime} ',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: InkWell(
            onTap: () {
              Provider.of<RecipeClass>(context, listen: false)
                  .updateIsFavorite(recipeModel);
            },
            child: recipeModel.isFavorite
                ? const Icon(
                    Icons.error,
                    size: 60,
                    color: Colors.white,
                  )
                : const Icon(
                    Icons.error_outline,
                    color: Colors.white,
                    size: 60,
                  ),
          ),
        ),
      ),
    );
  }
}
