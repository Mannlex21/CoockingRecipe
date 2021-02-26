import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

typedef OnImageSelected = Function(File imageFile);

class ImagePickerWidget extends StatelessWidget {
  final File imageFile;
  final OnImageSelected onImageSelected;

  ImagePickerWidget({@required this.imageFile, @required this.onImageSelected});

  Widget build(BuildContext context) {
    return Container(
      height: 320,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.cyan[300],
            Colors.cyan[800],
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        image: imageFile != null ? DecorationImage(image: FileImage(imageFile), fit: BoxFit.cover) : null,
      ),
      child: IconButton(
        icon: Icon(Icons.camera_alt),
        onPressed: () {
          _showPickerOptions(context);
        },
        iconSize: 90,
        color: Colors.white,
      ),
    );
  }

  void getImage(BuildContext context, source) async {
    var image = await ImagePicker().getImage(source: source);
    this.onImageSelected(File(image.path));
    Navigator.pop(context);
  }

  void _showPickerOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            ListTile(
              title: Text("Cámara"),
              leading: Icon(Icons.camera_alt),
              onTap: () => getImage(context, ImageSource.camera),
            ),
            ListTile(
              title: Text("Gallery"),
              leading: Icon(Icons.photo),
              onTap: () => getImage(context, ImageSource.gallery),
            )
          ],
        );
      },
    );
  }
}
