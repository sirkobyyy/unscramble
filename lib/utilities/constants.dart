import 'package:flutter/material.dart';

const kHeadingOneText = TextStyle(
  fontSize: 45,
  fontWeight: FontWeight.bold,
  fontFamily: 'Bloxat',
  color: Colors.black,
);

const kMedText = TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
  fontFamily: 'Bloxat',
);

const kSmallerText = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  fontFamily: 'Bloxat'
);

final kButtonStyle = ButtonStyle(
  backgroundColor:
  MaterialStateProperty.all(Colors.black),
  shape:
  MaterialStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
      side: BorderSide(color: Colors.red),
    ),
  ),
);