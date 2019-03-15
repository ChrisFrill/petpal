import 'package:flutter/material.dart';

DecorationImage image1 = DecorationImage(
  image: ExactAssetImage('assets/cat.jpg'),
  fit: BoxFit.cover,
);
DecorationImage image2 = DecorationImage(
  image: ExactAssetImage('assets/cat2.jpg'),
  fit: BoxFit.cover,
);

DecorationImage image3 = DecorationImage(
  image: ExactAssetImage('assets/dog.jpg'),
  fit: BoxFit.cover,
);


ImageProvider avatar1 = ExactAssetImage('assets/cat.jpg');
ImageProvider avatar2 = ExactAssetImage('assets/cat2.jpg');
ImageProvider avatar3 = ExactAssetImage('assets/dog.jpg');
