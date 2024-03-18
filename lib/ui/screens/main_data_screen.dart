import 'dart:io';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:recipe_book_local_database/providers/recipe_provider.dart';
import 'package:recipe_book_local_database/ui/screens/search_data_screen.dart';
import 'package:provider/provider.dart';

import '../widgets/container_widget.dart';

class MainRecipeScreen extends StatelessWidget {
  const MainRecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeClass>(
        builder: (BuildContext context, myProvider, Widget? child) => Scaffold(
              appBar: AppBar(
                title: Text(
                  '',
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.displayLarge,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                  ),
                ),
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
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: ((context) => SearchRecipeScreen(
                              recipes: myProvider.allRecipes)))),
                      child: const Icon(Icons.search)),
                  PopupMenuButton(
                    color: !myProvider.isDark ? Colors.white : null,
                    itemBuilder: ((context) => [
                          PopupMenuItem(
                            onTap: (() => Scaffold.of(context).openDrawer()),
                            child: Text(
                              'Open menu',
                              style: TextStyle(
                                color: Colors.deepPurple[900],
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            child: Text(
                              'About',
                              style: TextStyle(
                                color: Colors.deepPurple[900],
                                //color: Colors.deepPurple[900],
                              ),
                            ),
                          ),
                          PopupMenuItem(
                            onTap: (() => exit(0)),
                            child: Column(
                              children: [
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
                                      style: TextStyle(
                                        color: Colors.deepPurple[900],
                                        //color: Colors.deepPurple[900],
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
              floatingActionButton: FloatingActionButton(
                backgroundColor: Colors.deepPurple[900],
                onPressed: (() async {
                  await Navigator.pushNamed(context, '/new_recipe_screen');
                  // ignore: use_build_context_synchronously
                  Navigator.pushReplacementNamed(
                      context, '/main_recipe_screen');
                }),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
              drawer: Drawer(
                backgroundColor: !myProvider.isDark ? Colors.white : null,
                child: Column(
                  children: [
                    Container(
                      //width: double.infinity,
                      height: 200,
                    ),
                    ListTile(
                      title: const Text('Home'),
                      leading: Icon(
                        Icons.home,
                        color: Colors.deepPurple[900],
                      ),
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, '/main_recipe_screen');
                      },
                    ),
                    ListTile(
                      title: const Text('Marked Individuals'),
                      leading: Icon(
                        Icons.error,
                        color: Colors.deepPurple[900],
                      ),
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, '/favorite_recipes_screen');
                      },
                    ),
                    ListTile(
                      title: const Text('Task List'),
                      leading: Icon(
                        Icons.work,
                        color: Colors.deepPurple[900],
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/shopping_list_screen');
                      },
                    ),
                    Provider.of<RecipeClass>(context).isDark
                        ? ListTile(
                            title: const Text('Light Mode'),
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
                            title: const Text('Dark Mode'),
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
                  itemCount: myProvider.allRecipes.length,
                  itemBuilder: (context, index) {
                    return RecipeWidget(myProvider.allRecipes[index]);
                  }),
            ));
  }
}
