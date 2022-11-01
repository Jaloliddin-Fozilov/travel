import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/categories_provider.dart';
import 'package:travel/providers/places_provider.dart';
import 'package:travel/screens/add_place_screen.dart';
import 'package:travel/screens/place_details_screen.dart';
import 'package:travel/screens/places_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CategoryProvider(),
      child: ChangeNotifierProvider(
        create: (context) => PlacesProvider(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Sayohat',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            fontFamily: GoogleFonts.poppins().fontFamily,
          ),
          home: const PlacesListScreen(),
          routes: {
            AddPlaceScreen.routName: (ctx) => const AddPlaceScreen(),
            PlaceDetailsScreen.routName: (ctx) => const PlaceDetailsScreen(),
          },
        ),
      ),
    );
  }
}
