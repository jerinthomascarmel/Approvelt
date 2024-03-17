import 'package:flutter/material.dart';

class GlobalVariables {
  // COLORS
  static const appBarGradient = LinearGradient(
    colors: [
      Color.fromARGB(255, 29, 201, 192),
      Color.fromARGB(255, 125, 221, 216),
    ],
    stops: [0.5, 1.0],
  );

  static const secondaryColor = Color.fromRGBO(148, 139, 127, 1);
  static const backgroundColor = Colors.black54;
  static const Color greyBackgroundCOlor = Color(0xffebecee);
  static var selectedNavBarColor = Colors.red;
  static const unselectedNavBarColor = Colors.white;
}

LinearGradient get orangeGradient {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.deepOrange,
      Colors.deepOrange.shade400,
      Colors.deepOrange.shade300,
    ],
  );
}

LinearGradient get greenGradient {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.green,
      Colors.green.shade400,
      Colors.green.shade300,
    ],
  );
}

LinearGradient get redGradient {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.red,
      Colors.red.shade400,
      Colors.red.shade300,
    ],
  );
}

LinearGradient get purpleGradient {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Colors.purple,
      Colors.purple.shade400,
      Colors.purple.shade300,
    ],
  );
}
