import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/places_provider.dart';
import 'package:travel/widgets/image_input.dart';

class AddPlaceScreen extends StatefulWidget {
  AddPlaceScreen({super.key});

  static const routName = '/add-place';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  File? _savedImage;
  final _formKey = GlobalKey<FormState>();
  String _title = '';

  bool notImage = false;

  void _submit() {
    _takeSavedImage(_savedImage);
    if (_formKey.currentState!.validate() && _savedImage != null) {
      _formKey.currentState!.save();
      Provider.of<PlacesProvider>(context, listen: false)
          .addPlace(_title, _savedImage!);
      Navigator.of(context).pop();
    }
  }

  void _takeSavedImage(savedImage) {
    if (savedImage != null) {
      _savedImage = savedImage;
      setState(() {
        notImage = false;
      });
    } else {
      setState(() {
        notImage = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Sayohat joyini qo\'shish'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'Joy nomi',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Iltimos, joy nomini kiring.';
                          }
                        },
                        onSaved: (newValue) {
                          _title = newValue!;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                        width: double.infinity,
                      ),
                      ImageInput(_takeSavedImage, notImage),
                    ],
                  ),
                )),
          ),
          ElevatedButton(
            onPressed: _submit,
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0),
              ),
              elevation: 0,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: const EdgeInsets.symmetric(vertical: 15),
            ),
            child: const Text('Qo\'shish'),
          )
        ],
      ),
    );
  }
}
