import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:travel/helpers/location_helper.dart';
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CarouselSlider(options: CarouselOptions(height: 300.0), items: [
                Image.file(
                  place.image,
                  fit: BoxFit.cover,
                ),
                Image.network(
                  LocationHelper.getLocationImage(
                    latitude: place.location.latitude,
                    longtitude: place.location.longitude,
                  ),
                  fit: BoxFit.cover,
                ),
              ]),
              Positioned(
                top: 35,
                left: 10,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(100),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back),
                    color: Colors.white,
                    splashRadius: 1,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(
                Icons.location_on,
                color: Colors.grey,
              ),
              Text(
                place.location.address,
                style: const TextStyle(
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  place.title,
                  style: const TextStyle(
                    fontSize: 28,
                  ),
                ),
                Row(
                  children: [
                    RatingBarIndicator(
                      rating: place.rating,
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemCount: 5,
                      itemSize: 35.0,
                    ),
                    const SizedBox(width: 10),
                    Text(
                      place.rating.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Divider(endIndent: 360),
                const SizedBox(height: 20),
                Text(place.description),
              ],
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: ElevatedButton.icon(
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
        icon: const Icon(Icons.location_on),
        label: const Text('Manzilni xaritada ko\'rish'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50), // <-- Radius
          ),
        ),
      ),
    );
  }
}
