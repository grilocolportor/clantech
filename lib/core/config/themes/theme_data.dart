import 'package:flutter/material.dart';

final ThemeData lightTheme = ThemeData(

  brightness: Brightness.light,
   colorScheme: const ColorScheme.light(
    primary: Colors.amber,
    secondary: Colors.green,
    background: Colors.grey,
    brightness: Brightness.light, 
  )
);

final ThemeData darkTheme = ThemeData( 
  brightness: Brightness.dark, 
  colorScheme: const ColorScheme.dark(
    primary: Colors.black,
    background: Colors.black87,
    brightness: Brightness.dark, 
  )
);
