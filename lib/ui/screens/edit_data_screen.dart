import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_book_local_database/models/recipe_model.dart';
import 'package:provider/provider.dart';

import '../../providers/recipe_provider.dart';

class EditRecipeScreen extends StatefulWidget {
  final RecipeModel recipeModel;

  const EditRecipeScreen({super.key, required this.recipeModel});

  @override
  State<EditRecipeScreen> createState() => _EditRecipeScreenState();
}

class _EditRecipeScreenState extends State<EditRecipeScreen> {
  Future pickImage(BuildContext context, ImageSource source) async {
    final image = await ImagePicker().pickImage(source: source);
    if (image == null) return;
    // ignore: use_build_context_synchronously
    Provider.of<RecipeClass>(context, listen: false).image = File(image.path);
    setState(() {});
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
          title: Text(
            'Update 🖊️',
            style: GoogleFonts.poppins(
              textStyle: Theme.of(context).textTheme.displayLarge,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        body: Consumer<RecipeClass>(
          builder: (context, provider, child) => SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  TextField(
                    style: TextStyle(
                      color: Colors.deepPurple[900],
                    ),
                    controller: provider.nameController,
                    decoration: InputDecoration(
                        label: Text(
                          'Name',
                          style: GoogleFonts.poppins(
                            //textStyle: Theme.of(context).textTheme.displayLarge,
                            //fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple[900],
                            // fontStyle: FontStyle.italic,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    style: TextStyle(
                      color: Colors.deepPurple[900],
                    ),
                    keyboardType: TextInputType.number,
                    controller: provider.preperationTimeController,
                    decoration: InputDecoration(
                        label: Text(
                          'ID Number',
                          style: GoogleFonts.poppins(
                            //textStyle: Theme.of(context).textTheme.displayLarge,
                            //fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple[900],
                            // fontStyle: FontStyle.italic,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      PopupMenuButton(
                        color: !provider.isDark ? Colors.white : null,
                        itemBuilder: ((context) => [
                              PopupMenuItem(
                                onTap: (() =>
                                    pickImage(context, ImageSource.camera)),
                                child: Row(
                                  children: [
                                    Icon(Icons.camera_alt_outlined,
                                        color: Colors.deepPurple[900]),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Take a picture',
                                      style: GoogleFonts.poppins(
                                        //textStyle: Theme.of(context).textTheme.displayLarge,
                                        //fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurple[900],
                                        // fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem(
                                onTap: (() =>
                                    pickImage(context, ImageSource.gallery)),
                                child: Row(
                                  children: [
                                    Icon(Icons.image_outlined,
                                        color: Colors.deepPurple[900]),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      'Select a picture',
                                      style: GoogleFonts.poppins(
                                        //textStyle: Theme.of(context).textTheme.displayLarge,
                                        //fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.deepPurple[900],
                                        // fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ]),
                      ),
                      Text(
                        'Add a picture',
                        style: GoogleFonts.poppins(
                          //textStyle: Theme.of(context).textTheme.displayLarge,
                          //fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple[900],
                          // fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  Visibility(
                      visible: provider.image != null,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              provider.image = null;
                              setState(() {});
                            },
                            child: Icon(
                              Icons.cancel_outlined,
                              color: Colors.red[700],
                            ),
                          ),
                          provider.image != null
                              ? Image.file(
                                  provider.image!,
                                  width: 100,
                                  height: 100,
                                )
                              : Container(),
                        ],
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SizedBox(
                      height: 100,
                      child: TextField(
                        style: TextStyle(
                          color: Colors.deepPurple[900],
                        ),
                        expands: true,
                        maxLines: null,
                        controller: provider.ingredientsController,
                        decoration: InputDecoration(
                            label: Text(
                              'Personal Details',
                              style: GoogleFonts.poppins(
                                //textStyle: Theme.of(context).textTheme.displayLarge,
                                //fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple[900],
                                // fontStyle: FontStyle.italic,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SizedBox(
                      height: 100,
                      child: TextField(
                        style: TextStyle(
                          color: Colors.deepPurple[900],
                        ),
                        expands: true,
                        maxLines: null,
                        controller: provider.instructionsController,
                        decoration: InputDecoration(
                            label: Text(
                              'Institutional Details',
                              style: GoogleFonts.poppins(
                                //textStyle: Theme.of(context).textTheme.displayLarge,
                                //fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple[900],
                                // fontStyle: FontStyle.italic,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15))),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Colors.deepPurple[900],
                      ),
                    ),
                    onPressed: () {
                      if (provider.nameController.text.isEmpty ||
                          provider.preperationTimeController.text.isEmpty ||
                          provider.instructionsController.text.isEmpty ||
                          provider.ingredientsController.text.isEmpty ||
                          provider.image == null) {
                        Fluttertoast.showToast(
                          msg: "Please fill in all fields",
                          //toastLength: Toast.LENGTH_SHORT,
                          //gravity: ToastGravity.TOP,
                          //timeInSecForIosWeb: 1,
                          backgroundColor: Colors.deepPurple[900],
                          textColor: Colors.white,
                        );
                        return;
                      } else {
                        widget.recipeModel.name = provider.nameController.text;
                        widget.recipeModel.preperationTime = int.parse(
                            provider.preperationTimeController.text != ''
                                ? provider.preperationTimeController.text
                                : '0');
                        widget.recipeModel.image = provider.image;
                        widget.recipeModel.ingredients =
                            provider.ingredientsController.text;
                        widget.recipeModel.instructions =
                            provider.instructionsController.text;
                        provider.updateRecipe(widget.recipeModel);
                        provider.nameController.clear();
                        provider.preperationTimeController.clear();
                        provider.instructionsController.clear();
                        provider.ingredientsController.clear();
                        provider.image = null;
                        Navigator.of(context).pop();
                      } // widget.recipeModel.name = provider.nameController.text;
                    },
                    child: Center(
                        child: Text(
                      'Save Changes',
                      style: GoogleFonts.poppins(
                        //textStyle: Theme.of(context).textTheme.displayLarge,
                        //fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        // fontStyle: FontStyle.italic,
                      ),
                    )),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
