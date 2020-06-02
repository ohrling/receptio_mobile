import 'package:flutter/material.dart';

double scaleForDevice(BuildContext context) {
  final size = MediaQuery.of(context).size;
  if (size.height < 600) {
    return 0.7;
  }
  return 1.0;
}

String listToString(List<String> searchValues) {
  if (searchValues != null) {
    String str = searchValues.toString();
    String search = str.toLowerCase();
    search = search
        .split(RegExp('(?<=[a-z])\\s'))
        .join('%20')
        .replaceAll('[', '')
        .replaceAll(']', '')
        .replaceAll(' ', '');
    return search;
  }
  return '';
}
