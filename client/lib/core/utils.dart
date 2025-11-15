import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

void showSnackBar(BuildContext context, String error) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(error.toString()),
      ),
    );
}

//------------------------------------------------------------------
// additional functions to pick image and audio here for the
// upload song feature.
//--------------------------------------------------------------------
Future<File?> pickImage() async {
  try {
    final filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (filePickerResult != null) {
      return File(filePickerResult.files.first.xFile.path);
    }
    return null;
  } catch (e) {
    return null;
  }
}

Future<File?> pickAudio() async {
  try {
    final filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );
    if (filePickerResult != null) {
      return File(filePickerResult.files.first.xFile.path);
    }
    return null;
  } catch (e) {
    return null;
  }
}

String colorToHex(Color color, {bool includeAlpha = true}) {
  final a = color.alpha.toRadixString(16).padLeft(2, '0');
  final r = color.red.toRadixString(16).padLeft(2, '0');
  final g = color.green.toRadixString(16).padLeft(2, '0');
  final b = color.blue.toRadixString(16).padLeft(2, '0');

  return '#${includeAlpha ? a : ''}$r$g$b'.toUpperCase();
}

Color hexToColor(String hex) {
  hex = hex.replaceAll('#', '');
  if (hex.length == 6) hex = 'FF$hex'; // assume full opacity
  return Color(int.parse(hex, radix: 16));
}
