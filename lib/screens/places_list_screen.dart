import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/models/category_model.dart';
import 'package:travel/providers/categories_provider.dart';
import 'package:travel/providers/places_provider.dart';
import 'package:travel/screens/add_place_screen.dart';
import 'package:travel/screens/place_details_screen.dart';
import 'package:travel/widgets/home_categories.dart';
import 'package:travel/widgets/home_widget_title_and_button.dart';
import 'package:travel/widgets/places_items.dart';
import 'package:travel/widgets/welcome_text.dart';

class PlacesListScreen extends StatelessWidget {
  const PlacesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            child: const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: HomeCategories(),
            ),
          ),
          HomeWidgetTiitleAndButton(
            title: 'Recomendation',
            function: () {},
            child: const PlacesItems(),
          ),
        ],
      ),
    );
  }
}
