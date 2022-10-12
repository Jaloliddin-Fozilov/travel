import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as systemPath;
import 'package:travel/screens/add_place_screen.dart';

class ImageInput extends StatefulWidget {
  final Function takeSavedImage;
  final bool notImage;
  const ImageInput(this.takeSavedImage, this.notImage, {Key? key})
      : super(key: key);

  @override
  State<ImageInput> createState() => _ImageInputState();
}

class _ImageInputState extends State<ImageInput> {
  File? _imageFile;
  void _takePicture() async {
    final imagePicker = ImagePicker();
    final photo = await imagePicker.pickImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );
    if (photo != null) {
      setState(() {
        _imageFile = File(photo.path);
      });
    }
    final pathProvider = await systemPath.getApplicationDocumentsDirectory();
    final fileName = path.basename(photo!.path);
    final savedImage = await _imageFile!.copy('${pathProvider.path}/$fileName');
    widget.takeSavedImage(savedImage);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
            border: Border.all(
                width: 1, color: widget.notImage ? Colors.red : Colors.grey),
          ),
          alignment: Alignment.center,
          child: _imageFile != null
              ? Image.file(
                  _imageFile!,
                  fit: BoxFit.cover,
                  width: double.infinity,
                )
              : Text('Rasm yuklanmagan',
                  style: TextStyle(
                    color: widget.notImage ? Colors.red : Colors.black,
                  )),
        ),
        TextButton.icon(
          onPressed: _takePicture,
          icon: const Icon(Icons.image_search),
          label: const Text('Rasm yuklash'),
        )
      ],
    );
  }
}
