import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/categories_provider.dart';
import 'package:travel/providers/places_provider.dart';
import 'package:travel/widgets/place_item.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  static const routName = '/category';

  @override
  Widget build(BuildContext context) {
    final argument = ModalRoute.of(context)!.settings.arguments;
    final category = Provider.of<CategoryProvider>(context)
        .findCategoryById(argument as String);
    final places =
        Provider.of<PlacesProvider>(context).getPlacesByCategoryId(argument);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: Text(category.title),
      ),
      body: places.isEmpty
          ? const Center(
              child: Text('Joylar topilmadi('),
            )
          : Padding(
              padding: const EdgeInsets.only(left: 20, right: 10),
              child: ListView.builder(
                itemCount: places.length,
                itemBuilder: (context, index) =>
                    PlaceItem(id: places[index].id),
              ),
            ),
    );
  }
}
