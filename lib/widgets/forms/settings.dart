import 'package:PetPal/api/petpal_api.dart';
import 'package:flutter/material.dart';

import 'package:flutter_form_builder/flutter_form_builder.dart';

class SettingsForm extends StatefulWidget {
  @override
  SettingsFormState createState() {
    return SettingsFormState();
  }
}

// Create a corresponding State class. This class will hold the data related to
// the form.
class SettingsFormState extends State<SettingsForm> {
  // Create a global key that will uniquely identify the Form widget and allow
  //
  GlobalKey<FormBuilderState> _fbKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Form(
            child: FormBuilder(
              context,
              autovalidate: true,
              controls: [
                FormBuilderInput.textField(
                  decoration: InputDecoration(labelText: "Country"),
                  type: FormBuilderInput.TYPE_TEXT,
                  attribute: "name",
                  require: true,
                  min: 3,
                ),
              ],
              
            ),
          ),
          MaterialButton(
              child: Text('External submit'),
              onPressed: () {
                _fbKey.currentState.save();
                if (_fbKey.currentState.validate()) {
                  print('validationSucceded');
                  print(_fbKey.currentState.value);
                  PetPalApi().requestLoginAPI(context, _fbKey.currentState.value);
                } else {
                  print("External FormValidation failed");
                }
              },
            ),
        ],
      ),
    );
  }
}
