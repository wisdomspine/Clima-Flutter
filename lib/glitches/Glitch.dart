import 'package:flutter/material.dart';

///Error objects for easy user printing
/// [title] a short title for the error, usually shown in alert titles
/// [description] a brief and clear description of the problem for the user

class Glitch {
  final String title;
  final String description;

  Glitch({@required this.title, @required this.description});
}
