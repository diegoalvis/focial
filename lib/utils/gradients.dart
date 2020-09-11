import 'package:flutter/material.dart';

class Gradients {
  static final gradients = [_indigoLightBlue, _indigoViolet, _pink, _reddish];
}

final List<Color> _indigoLightBlue = List.generate(
    _indigoLightBlueColorArray.length,
    (i) => Color(int.parse("0xff${_indigoLightBlueColorArray[i]}")));

final List<Color> _indigoViolet = List.generate(_indigoVioletColorArray.length,
    (i) => Color(int.parse("0xff${_indigoVioletColorArray[i]}")));

final List<Color> _pink = List.generate(_pinkColorArray.length,
    (i) => Color(int.parse("0xff${_pinkColorArray[i]}")));

final List<Color> _reddish = List.generate(_reddishColorArray.length,
    (i) => Color(int.parse("0xff${_reddishColorArray[i]}")));

const _indigoLightBlueColorArray = [
  "7400b8",
  "6930c3",
  "5e60ce",
  "5390d9",
  "4ea8de",
  "48bfe3",
  "56cfe1",
  "64dfdf",
  "72efdd",
  "80ffdb"
];
const _pinkColorArray = [
  "f65be3",
  "f679e5",
  "f497da",
  "f8bdc4",
  "def6ca",
];
const _indigoVioletColorArray = [
  "2d00f7",
  "6a00f4",
  "8900f2",
  "a100f2",
  "b100e8",
  "bc00dd",
  "d100d1",
  "db00b6",
  "e500a4",
  "f20089"
];
const _reddishColorArray = ["ef7674", "ec5766", "da344d", "d91e36", "c42348"];
