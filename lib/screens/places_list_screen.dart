import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/places_provider.dart';
import 'package:travel/screens/add_place_screen.dart';

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
      body: Consumer<PlacesProvider>(
        builder: (context, placesProvider, child) {
          if (placesProvider.list.isNotEmpty) {
            return ListView.builder(
              itemCount: placesProvider.list.length,
              itemBuilder: (c, i) => ListTile(
                leading: CircleAvatar(
                  backgroundImage: FileImage(placesProvider.list[i].image),
                ),
                title: Text(placesProvider.list[i].title),
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
      ),
    );
  }
}
