import 'package:PetPal/api/petpal_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class Registration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyCustomForm();
  }
}

// Create a Form Widget
class MyCustomForm extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class. This class will hold the data related to
// the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a GlobalKey<FormState>, not a GlobalKey<MyCustomFormState>!
  GlobalKey<FormBuilderState> _fbKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey we created above
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          FormBuilder(
              context,
              key: _fbKey,
              autovalidate: false,
              controls: [
                FormBuilderInput.textField(
                  decoration: InputDecoration(labelText: "Email"),
                  type: FormBuilderInput.TYPE_EMAIL,
                  attribute: "email",
                  require: true,
                  min: 3,
                ),
                FormBuilderInput.textField(
                  decoration: InputDecoration(labelText: "Name"),
                  type: FormBuilderInput.TYPE_TEXT,
                  attribute: "name",
                  require: true,
                  min: 3,
                ),
                FormBuilderInput.password(
                    decoration: InputDecoration(labelText: "Password"),
                    attribute: "password",
                    require: true,
                    min: 3)
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
                  print('validationSucceded');
                  print(_fbKey.currentState.value);
                  PetPalApi()
                      .requestRegisterAPI(context, _fbKey.currentState.value);
                } else {
                  print("External FormValidation failed");
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
