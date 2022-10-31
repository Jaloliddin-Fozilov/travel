import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/places_provider.dart';
import 'package:travel/screens/add_place_screen.dart';
import 'package:travel/screens/place_details_screen.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sayohat'),
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AddPlaceScreen.routName),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
          future:
              Provider.of<PlacesProvider>(context, listen: false).getPlaces(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return Consumer<PlacesProvider>(
              builder: (context, placesProvider, child) {
                if (placesProvider.list.isNotEmpty) {
                  return ListView.builder(
                    itemCount: placesProvider.list.length,
                    itemBuilder: (c, i) => ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            FileImage(placesProvider.list[i].images[0]),
                      ),
                      title: Text(placesProvider.list[i].title),
                      subtitle: Text(placesProvider.list[i].location.address),
                      onTap: () => Navigator.of(context).pushNamed(
                        PlaceDetailsScreen.routName,
                        arguments: placesProvider.list[i].id,
                      ),
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
          }),
    );
  }
}
