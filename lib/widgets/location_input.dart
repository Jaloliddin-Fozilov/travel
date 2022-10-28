import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:travel/helpers/location_helper.dart';
import 'package:travel/models/place.dart';
import 'package:travel/screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewLocationImage;

  Future<void> _getCurrentLocation() async {
    final _locationData = await Location().getLocation();

    setState(() {
      _previewLocationImage = LocationHelper.getLocationImage(
        latitude: _locationData.latitude!,
        longtitude: _locationData.longitude!,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          height: 150,
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
          ),
          child: _previewLocationImage == null
              ? const Text('Joy tanlanmagan')
              : Image.network(
                  _previewLocationImage!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              icon: const Icon(Icons.location_on),
              label: const Text('Mening manzilim'),
            ),
            ElevatedButton.icon(
              onPressed: () async {
                final selectedLocation = await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => MapScreen(
                      placeLocation: PlaceLocation(
                          latitude: 41.311081,
                          longitude: 69.240562,
                          address: 'Tashkent'),
                      isSelecting: true,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.map),
              label: const Text('Manzil tanlash'),
            ),
          ],
        )
      ],
    );
  }
}
