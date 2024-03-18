import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/recipe_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NewRecipeScreen extends StatefulWidget {
  const NewRecipeScreen({super.key});

  @override
  State<NewRecipeScreen> createState() => _NewRecipeScreenState();
}

class _NewRecipeScreenState extends State<NewRecipeScreen> {
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
          title: Text(
            '',
            style: GoogleFonts.poppins(
              textStyle: Theme.of(context).textTheme.displayLarge,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontStyle: FontStyle.italic,
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
                                    Icon(
                                      Icons.camera_alt_outlined,
                                      color: Colors.deepPurple[900],
                                    ),
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
                        // style: TextStyle(fontSize: 16),
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
                            child: const Icon(
                              Icons.cancel_outlined,
                              color: Colors.red,
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
                        onChanged: (value) {
                          if (value.isEmpty) {
                            Fluttertoast.showToast(
                              msg: "Please fill in Personal Details",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.red,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }
                        },
                        //if(value != null && ingredientsController.isEmpty){},
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
                            fillColor: Colors.deepPurple[900],
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
                        provider.insertNewRecipe();
                        provider.nameController.clear();
                        provider.preperationTimeController.clear();
                        provider.instructionsController.clear();
                        provider.ingredientsController.clear();
                        provider.image = null;
                        Navigator.of(context).pop();
                      }
                    },
                    child: Center(
                      child: Text(
                        'Save',
                        style: GoogleFonts.poppins(
                          //textStyle: Theme.of(context).textTheme.displayLarge,
                          //fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          // fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
