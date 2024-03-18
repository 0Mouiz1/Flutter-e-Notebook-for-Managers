import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/item_provider.dart';
import '../../providers/recipe_provider.dart';
import '../widgets/item_widget.dart';

class ShoppingListScreen extends StatelessWidget {
  const ShoppingListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<RecipeClass, ItemClass>(
        builder: ((context, provider, provider2, child) => Scaffold(
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.deepPurple[900],
              iconTheme: IconThemeData(
                color: Colors.white, // Change the color of the drawer icon here
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20), // Circular border radius
                ),
              ),
              title: const Text(
                'Tasks 🖊️',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              // actions: [
              //   InkWell(
              //       onTap: () => provider2.deleteItems(),
              //       child: const Icon(Icons.delete))
              // ],
            ),
            drawer: Drawer(
              backgroundColor: Colors.white,
              child: Column(
                children: [
                  Container(
                    height: 200,
                  ),
                  ListTile(
                    title: Text(
                      'Home',
                      style: TextStyle(color: Colors.deepPurple[900]),
                    ),
                    leading: const Icon(
                      Icons.home,
                      color: Colors.black,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/main_recipe_screen');
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Marked list',
                      style: TextStyle(color: Colors.deepPurple[900]),
                    ),
                    leading: const Icon(
                      Icons.error,
                      color: Colors.red,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/favorite_recipes_screen');
                    },
                  ),
                  ListTile(
                    title: Text(
                      'Task List',
                      style: TextStyle(color: Colors.deepPurple[900]),
                    ),
                    leading: const Icon(
                      Icons.work,
                      color: Colors.black,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/shopping_list_screen');
                    },
                  ),
                  provider.isDark
                      ? ListTile(
                          title: Text(
                            'Light Mode',
                            style: TextStyle(color: Colors.deepPurple[900]),
                          ),
                          leading: const Icon(
                            Icons.light_mode_outlined,
                            color: Colors.black,
                          ),
                          onTap: () {
                            provider.changeIsDark();
                            Navigator.pop(context);
                          },
                        )
                      : ListTile(
                          title: Text(
                            'Dark Mode',
                            style: TextStyle(color: Colors.deepPurple[900]),
                          ),
                          leading: const Icon(
                            Icons.dark_mode_outlined,
                            color: Colors.black,
                          ),
                          onTap: () {
                            provider.changeIsDark();
                            Navigator.pop(context);
                          },
                        ),
                ],
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: provider2.allItems.length,
                      itemBuilder: (context, index) {
                        return ItemWidget(provider2.allItems[index]);
                      }),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: TextField(
                        controller: provider2.textEditingController,
                        decoration: InputDecoration(
                            label: const Text(
                              'Add a Task',
                              // style: TextStyle(
                              //   color: Colors.green,
                              // ),
                            ),
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                //color: Colors.green,
                                //width = 2,
                                //style = BorderStyle.solid,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            )),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.deepPurple[900]),
                      ),
                      onPressed: () {
                        provider2.insertNewItem();
                        provider2.textEditingController.clear();
                      },
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
              ],
            ))));
  }
}
