import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ImageInput extends StatefulWidget {
  const ImageInput({super.key, required this.pickimage});
  final void Function(File image) pickimage;
  @override
  State<ImageInput> createState() {
    return ImageInputState();
  }
}

class ImageInputState extends State<ImageInput> {
  File? _chosenImage;
  void _clickPicture() async {
    final imgPicker = ImagePicker();
    final selImage =
        await imgPicker.pickImage(source: ImageSource.camera, maxWidth: 600);
    if (selImage == null) {
      return;
    }
    setState(() {
      _chosenImage = File(selImage.path);
    });
    widget.pickimage(_chosenImage!);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = TextButton.icon(
      onPressed: _clickPicture,
      icon: const Icon(Icons.camera_alt_rounded),
      label: const Text("Add a photo."),
    );

    if (_chosenImage != null) {
      content = GestureDetector(
        onTap: _clickPicture,
        child: Image.file(
          _chosenImage!,
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      );
    }

    return Container(
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
          ),
        ),
        height: 250,
        width: double.infinity,
        alignment: Alignment.center,
        child: content);
  }
}
