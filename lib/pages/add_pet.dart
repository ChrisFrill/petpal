import 'package:PetPal/widgets/forms/add_pet.dart';
import 'package:flutter/material.dart';

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
