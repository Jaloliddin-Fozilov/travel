import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/categories_provider.dart';
import 'package:travel/providers/places_provider.dart';
import 'package:travel/screens/add_place_screen.dart';
import 'package:travel/screens/place_details_screen.dart';
import 'package:travel/widgets/home_widget_title_and_button.dart';
import 'package:travel/widgets/welcome_text.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<CategoryProvider>(context).list;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: const CircleAvatar(
          backgroundImage: AssetImage('assets/avatar.jpg'),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(AddPlaceScreen.routName),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          const WelcomeText(),
          const SizedBox(height: 10),
          HomeWidgetTiitleAndButton(
            title: 'Category',
            function: () {},
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories
                    .map((category) => Container(
                          height: 80,
                          padding: const EdgeInsets.all(10),
                          margin: const EdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                category.color.withAlpha(100),
                                category.color,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(category.title),
                        ))
                    .toList(),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder(
                future: Provider.of<PlacesProvider>(context, listen: false)
                    .getPlaces(),
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
                                  FileImage(placesProvider.list[i].image),
                            ),
                            title: Text(placesProvider.list[i].title),
                            subtitle:
                                Text(placesProvider.list[i].location.address),
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
          ),
        ],
      ),
    );
  }
}
