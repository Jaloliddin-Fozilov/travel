import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:travel/helpers/location_helper.dart';
import 'package:travel/models/place.dart';
import 'package:travel/screens/map_screen.dart';

class LocationInput extends StatefulWidget {
  final Function takePickedLocation;
  const LocationInput(this.takePickedLocation, {super.key});

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewLocationImage;

  Future<void> _getCurrentLocation() async {
    final _locationData = await Location().getLocation();

    _getLocationImage(
      LatLng(_locationData.latitude!, _locationData.longitude!),
    );
  }

  void _getLocationImage(LatLng location) async {
    setState(() {
      _previewLocationImage = LocationHelper.getLocationImage(
        latitude: location.latitude,
        longtitude: location.longitude,
      );
    });

    final String formattedAdress =
        await LocationHelper.getFormattedAddress(location);

    widget.takePickedLocation(
      location.latitude,
      location.longitude,
      formattedAdress,
    );
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
                final selectedLocation =
                    await Navigator.of(context).push<LatLng>(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (ctx) => MapScreen(
                      placeLocation: PlaceLocation(
                          latitude: 41.311081,
                          longitude: 69.240562,
                          address: 'Tashkent'),
                      isSelecting: true,
                    ),
                  ),
                );
                if (selectedLocation == null) {
                  return;
                }

                _getLocationImage(selectedLocation);
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
