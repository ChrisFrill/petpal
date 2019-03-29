import 'dart:math';

import 'package:PetPal/api/petpal_api.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:image_picker/image_picker.dart';

// Create a Form Widget
class AddPetForm extends StatefulWidget {
  @override
  AddPetFormState createState() {
    return AddPetFormState();
  }
}

// Create a corresponding State class. This class will hold the data related to
// the form.
class AddPetFormState extends State<AddPetForm> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a GlobalKey<FormState>, not a GlobalKey<AddPetFormState>!

  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    print("image");
    print(image);
    setState(() {
      _image = image;
    });
  }

  GlobalKey<FormBuilderState> _fbKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Center(
              child: _image == null
                  ? Text('No image selected.')
                  : Image.file(_image),
            ),
            FloatingActionButton(
              onPressed: getImage,
              tooltip: 'Pick Image',
              child: Icon(Icons.add_a_photo),
            ),
            FormBuilder(
              context,
              key: _fbKey,
              autovalidate: false,
              controls: [
                FormBuilderInput.textField(
                  decoration: InputDecoration(labelText: "Name"),
                  type: FormBuilderInput.TYPE_TEXT,
                  attribute: "name",
                  min: 3,
                ),
                FormBuilderInput.dropdown(
                  attribute: "type",
                  decoration: InputDecoration(labelText: "Type"),
                  options: [
                    FormBuilderInputOption(value: "Dog"),
                    FormBuilderInputOption(value: "Cat"),
                  ],
                ),
                FormBuilderInput.dropdown(
                  attribute: "gender",
                  decoration: InputDecoration(labelText: "Gender"),
                  options: [
                    FormBuilderInputOption(value: "female"),
                    FormBuilderInputOption(value: "male"),
                  ],
                ),
                FormBuilderInput.datePicker(
                  decoration: InputDecoration(labelText: "Date of Birth"),
                  attribute: "dob",
                  firstDate: DateTime(1970),
                  lastDate: DateTime.now().add(Duration(days: 1)),
                  format: 'dd, MM yyyy',
                ),
                FormBuilderInput.checkbox(
                  label: Text('Vaccinated'),
                  attribute: "vaccinated",
                ),
                FormBuilderInput.checkbox(
                  label: Text('Spayed'),
                  attribute: "spayed",
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(500.0),
                ),
                color: Colors.deepOrange,
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
                onPressed: () {
                  _fbKey.currentState.save();
                  if (_fbKey.currentState.validate()) {
                    var rng = new Random();

                    String filename = rng.nextInt(10000).toString() + ".jpg";
                    _fbKey.currentState.value["photoPath"] =
                        filename;
                        print(_fbKey.currentState.value);
                    PetPalApi().uploadFile(context, _image.toString(), filename);
                    PetPalApi().addPet(context, _fbKey.currentState.value);
                  } else {
                    print("External FormValidation failed");
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               TextFormField(
//                 decoration: InputDecoration(labelText: 'Name:'),
//                 validator: (value) {
//                   if (value.isEmpty) {
//                     return 'Please enter some text';
//                   }
//                 },
//               ),
//               TextFormField(
//                 obscureText: true,
//                 decoration: InputDecoration(labelText: 'Birth date:'),
//                 validator: (value) {
//                   if (value.isEmpty) {
//                     return 'Please enter some text';
//                   }
//                 },
//               ),
//               DropdownButtonFormField(
//                 decoration: InputDecoration(labelText: 'Animal type:'),
//                 value: animalType,
//                 onChanged: (String changedAnimalType) {
//                   setState(() {
//                     animalType = changedAnimalType;
//                   });
//                 },
//                 items: <String>['Dog', 'Cat', 'Hamster', 'Pinguin']
//                     .map<DropdownMenuItem<String>>((String changedAnimalType) {
//                   return DropdownMenuItem<String>(
//                     value: changedAnimalType,
//                     child: Text(changedAnimalType),
//                   );
//                 }).toList(),
//               ),
//               DropdownButtonFormField(
//                 decoration: InputDecoration(labelText: 'Sex:'),
//                 value: sexType,
//                 onChanged: (String changedSexType) {
//                   setState(() {
//                     sexType = changedSexType;
//                   });
//                 },
//                 items: <String>['Male', 'Female']
//                     .map<DropdownMenuItem<String>>((String changedSexType) {
//                   return DropdownMenuItem<String>(
//                     value: changedSexType,
//                     child: Text(changedSexType),
//                   );
//                 }).toList(),
//               ),
//               Center(
//                 child: _image == null
//                     ? Text('No image selected.')
//                     : Image.file(_image),
//               ),
//               FloatingActionButton(
//                 onPressed: getImage,
//                 tooltip: 'Pick Image',
//                 child: Icon(Icons.add_a_photo),
//               ),
//               Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 16.0),
//                 child: RaisedButton(
//                   color: Colors.deepOrange,
//                   textColor: Colors.white,
//                   onPressed: () {
//                     // Validate will return true if the form is valid, or false if
//                     // the form is invalid.
//                     if (_formKey.currentState.validate()) {
//                       // If the form is valid, we want to show a Snackbar
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => PetFinder()),
//                       );
//                     }
//                   },
//                   child: Text('Submit'),
//                 ),
//               ),
//             ],
//           ),
