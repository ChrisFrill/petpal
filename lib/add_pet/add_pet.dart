import 'package:flutter/material.dart';

import '../navigation/navdrawer.dart';
import './add_pet_form.dart';
import '../icons/petpal_icons.dart';

class AddPet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Text('Add a new pet'),
          ],
        ),
      ),
      body: AddPetForm(),
    );
  }
}
