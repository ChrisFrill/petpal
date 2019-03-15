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
  final _formKey = GlobalKey<FormState>();

  File _image;

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: FormBuilder(
            context,
            autovalidate: false,
            controls: [
              FormBuilderInput.textField(
                type: FormBuilderInput.TYPE_TEXT,
                attribute: "name",
                label: "Name",
                require: true,
                min: 3,
              ),
              FormBuilderInput.dropdown(
                attribute: "type",
                require: true,
                label: "Animal type",
                options: [
                  FormBuilderInputOption(value: "Dog"),
                  FormBuilderInputOption(value: "Cat"),
                  FormBuilderInputOption(value: "Penguin"),
                  FormBuilderInputOption(value: "Hamster"),
                ],
              ),
              FormBuilderInput.datePicker(
                label: "Date of Birth",
                attribute: "dob",
                hint: "Hint"
              ),
              FormBuilderInput.checkbox(
                label: "Vaccinated",
                attribute: "vaccinated",
                
              ),
              FormBuilderInput.checkbox(
                label: "Spayed",
                attribute: "spayed",
              )
            ],
            onSubmit: (formValue) {
              if (formValue != null) {
                print(formValue);
              } else {
                print("Form invalid");
              }
            },
          ),
        ));
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



