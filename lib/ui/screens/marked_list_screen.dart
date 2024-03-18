import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recipe_book_local_database/ui/screens/search_data_screen.dart';
import 'package:provider/provider.dart';

import '../../providers/recipe_provider.dart';
import '../widgets/container_widget.dart';

class FavoriteRecipesScreen extends StatelessWidget {
  const FavoriteRecipesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeClass>(
      builder: (BuildContext context, myProvider, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              '',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
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
            actions: [
              InkWell(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => SearchRecipeScreen(
                          recipes: myProvider.favoriteRecipes)))),
                  child: const Icon(Icons.search)),
              PopupMenuButton(
                color: !myProvider.isDark ? Colors.white : null,
                itemBuilder: ((context) => [
                      PopupMenuItem(
                        onTap: (() => Scaffold.of(context).openDrawer()),
                        child: Text(
                          'Open menu',
                          style: GoogleFonts.poppins(
                            //textStyle: Theme.of(context).textTheme.displayLarge,
                            //fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple[900],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        child: Text(
                          'About',
                          style: GoogleFonts.poppins(
                            //textStyle: Theme.of(context).textTheme.displayLarge,
                            //fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple[900],
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                      PopupMenuItem(
                        onTap: (() => exit(0)),
                        child: Column(
                          children: [
                            // const Divider(
                            //   color: Colors.black,
                            //   thickness: 1,
                            // ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.exit_to_app_outlined,
                                  color: Colors.deepPurple[900],
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Exit',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.deepPurple[900],
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ]),
              ),
            ],
          ),
          drawer: Drawer(
            backgroundColor: !myProvider.isDark ? Colors.white : null,
            child: Column(
              children: [
                Container(
                  // width: double.infinity,
                  height: 200,
                  //color: !myProvider.isDark ? Colors.blue : null,
                  //child: const Center(
                  //   child: CircleAvatar(
                  //     backgroundImage: AssetImage('images/food_logo.png'),
                  //     radius: 50,
                  //   ),
                  // ),
                ),
                ListTile(
                  title: Text(
                    'Home',
                    style: TextStyle(color: Colors.deepPurple[900]),
                  ),
                  leading: Icon(
                    Icons.home,
                    color: Colors.deepPurple[900],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/main_recipe_screen');
                  },
                ),
                ListTile(
                  title: Text(
                    'Marked Individuals',
                    style: TextStyle(color: Colors.deepPurple[900]),
                  ),
                  leading: Icon(
                    Icons.error,
                    color: Colors.deepPurple[900],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/favorite_recipes_screen');
                  },
                ),
                // const Divider(
                //   thickness: 1,
                // ),
                ListTile(
                  title: Text(
                    'Tasks List',
                    style: TextStyle(color: Colors.deepPurple[900]),
                  ),
                  leading: Icon(
                    Icons.work,
                    color: Colors.deepPurple[900],
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, '/shopping_list_screen');
                  },
                ),
                // const Divider(
                //   thickness: 1,
                // ),
                Provider.of<RecipeClass>(context).isDark
                    ? ListTile(
                        title: Text(
                          'Light Mode',
                          style: TextStyle(color: Colors.deepPurple[900]),
                        ),
                        leading: Icon(
                          Icons.light_mode_outlined,
                          color: Colors.deepPurple[900],
                        ),
                        onTap: () {
                          Provider.of<RecipeClass>(context, listen: false)
                              .changeIsDark();
                          Navigator.pop(context);
                        },
                      )
                    : ListTile(
                        title: Text(
                          'Dark Mode',
                          style: TextStyle(color: Colors.deepPurple[900]),
                        ),
                        leading: Icon(
                          Icons.dark_mode_outlined,
                          color: Colors.deepPurple[900],
                        ),
                        onTap: () {
                          Provider.of<RecipeClass>(context, listen: false)
                              .changeIsDark();
                          Navigator.pop(context);
                        },
                      ),
              ],
            ),
          ),
          body: ListView.builder(
              itemCount: myProvider.favoriteRecipes.length,
              itemBuilder: (context, index) {
                return RecipeWidget(myProvider.favoriteRecipes[index]);
              }),
        );
      },
    );
  }
}
