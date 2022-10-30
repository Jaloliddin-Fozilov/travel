import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/models/place.dart';
import 'package:travel/providers/places_provider.dart';
import 'package:travel/screens/map_screen.dart';

class PlaceDetailsScreen extends StatelessWidget {
  static const routName = '/details';
  const PlaceDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)!.settings.arguments;
    final place = Provider.of<PlacesProvider>(context).getById(id as String);
    return Scaffold(
      appBar: AppBar(
        title: Text(place.title),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 250,
            width: double.infinity,
            child: Image.file(
              place.image,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            place.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => MapScreen(
                    placeLocation: place.location,
                    isSelecting: false,
                  ),
                ),
              );
            },
            child: const Text('Manzilni xaritada ko\'rish'),
          ),
        ],
      ),
    );
  }
}
