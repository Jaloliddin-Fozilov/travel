import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/models/place.dart';
import 'package:travel/providers/places_provider.dart';
import 'package:travel/widgets/image_input.dart';
import 'package:travel/widgets/location_input.dart';

class AddPlaceScreen extends StatefulWidget {
  const AddPlaceScreen({super.key});

  static const routName = '/add-place';

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  File? _savedImage;
  final _formKey = GlobalKey<FormState>();
  PlaceLocation? _placeLocation;
  String _title = '';

  bool notImage = false;

  void _takePickedLocation(double latitude, double longitude, String address) {
    _placeLocation = PlaceLocation(
      latitude: latitude,
      longitude: longitude,
      address: address,
    );
  }

  void _submit() {
    _takeSavedImage(_savedImage);
    if (_formKey.currentState!.validate() &&
        _savedImage != null &&
        _placeLocation != null) {
      _formKey.currentState!.save();
      Provider.of<PlacesProvider>(context, listen: false)
          .addPlace(_title, _savedImage!, _placeLocation!);
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
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                    key: _formKey,
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
                        const SizedBox(
                          height: 20,
                          width: double.infinity,
                        ),
                        LocationInput(_takePickedLocation),
                      ],
                    )),
              ),
            ),
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
