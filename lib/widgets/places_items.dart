import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/places_provider.dart';
import 'package:travel/widgets/place_item.dart';

class PlacesItems extends StatelessWidget {
  final bool isPopular;
  const PlacesItems({
    required this.isPopular,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<PlacesProvider>(context, listen: false).getPlaces(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Consumer<PlacesProvider>(
            builder: (context, placesProvider, child) {
              if (placesProvider.list.isNotEmpty) {
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: isPopular
                        ? placesProvider.popularPlaces
                            .map(
                              (place) => PlaceItem(id: place.id),
                            )
                            .toList()
                        : placesProvider.list
                            .map(
                              (place) => PlaceItem(id: place.id),
                            )
                            .toList(),
                  ),
                );
              } else {
                return child!;
              }
            },
            child: const Center(
              child: Text(
                  'Sayohat joylari mavjud emas, iltimos + tugamasini bosib qo\'shing'),
            ),
          );
        });
  }
}
