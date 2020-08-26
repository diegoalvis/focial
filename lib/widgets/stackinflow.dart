import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:google_fonts/google_fonts.dart';

class StackInFlow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0,
      margin: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Developed with  ',
            style: TextStyle(fontSize: 14.0),
          ),
          Icon(
            FontAwesomeIcons.solidHeart,
            color: Colors.red,
            size: 20.0,
          ),
          Text(
            '  by',
            style: TextStyle(fontSize: 14.0),
          ),
          Text(
            ' StackInFlow',
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 14.0),
          ),
        ],
      ),
    );
  }
}
